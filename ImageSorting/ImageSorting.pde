import java.util.*;

float b = 255;
float g = 0;
float r = 0;
int del = 20;
PImage image;
PImage[] clrs;
int[] ar;
int n;
int delay = 1;
Thread thread;

void setup(){
  size(880, 1080);
  image  = loadImage("chadwick.png");
  clrs = new PImage[width/del*height/del];
  n = clrs.length;
  ar = new int[n];
  ArrayList<Integer> temp = new ArrayList<Integer>();
  for (int i = 0; i < n; i++){
    temp.add(i);
  }
  Collections.shuffle(temp);
  for (int i = 0; i < n; i++){
    ar[i] = temp.get(i);
  }
  int x = 0;
  for (int i = 0; i < width/del; i++){
    for (int j = 0; j < height/del; j++){
      clrs[x++] = image.get(i*del, j*del, del, del);
    }
  }
  thread = new Thread(){
    @Override
    public void run(){
      mergeSort(0, n-1);
      //radixSort(2);
    }
  };
  thread.start();
}

void draw(){
  background(0);
  for (int i = 0; i < n; i++){
    image(clrs[ar[i]], (i/(height/del))*del, (i%(height/del))*del);
  }
}

void radixSort(int r){
  int m = 1;
  int mxx = n;
  long temp = 1;
  while (temp <= mxx){
    temp = temp*r;
    m++;
  }
  int[][] mtr = new int[n][m];
  for (int i = 0; i < n; i++){
    int val = ar[i];
    int x = 0;
    while (val != 0){
      mtr[ar[i]][x++] = val%r;
      val /= r;
    }
    while (x < m) mtr[ar[i]][x++] = 0;
  }
  ArrayList<Queue<Integer>> qu = new ArrayList<Queue<Integer>>();
  for (int i = 0; i < r; i++){
    qu.add(new LinkedList<Integer>());
  }
  for (int i = 0; i < m; i++){
    for (int j = 0; j < n; j++){
      qu.get(mtr[ar[j]][i]).add(ar[j]);
    }
    int x = 0;
    for (int j = 0; j < r; j++){
      while (qu.get(j).size()!=0){
        waitt();
        ar[x++] = qu.get(j).remove();
      }
    }
  }
}


void heapSort(){
  for (int i = 1; i < n; i++){
    int j = i;
    while (j >= 1){
      if (ar[j] > ar[(j-1)/2]){
        try{
          waitt();
        }catch(Exception e){
        
        }
        int temp = ar[(j-1)/2];
        ar[(j-1)/2] = ar[j]; 
        ar[j] = temp;
        j = (j-1)/2;
      }else{
        break;
      }
    }
  }
  for (int i = n-1; i >= 0; i--){
    int temp = ar[0];
    ar[0] = ar[i]; 
    ar[i] = temp;
    int j = 0;
    while (2*j + 1 < i){
      if (2*j + 2 < i){
        int mi = max(ar[2*j+1], ar[2*j+2]);
        if (mi > ar[j]){
          if (mi == ar[2*j+1]){
            try{
              waitt();
            }catch(Exception e){
             
            }
            temp = ar[j];
            ar[j] = ar[2*j+1]; 
            ar[2*j+1] = temp;
            j = 2*j+1;
          }else{
            try{
              waitt();
            }catch(Exception e){
             
            }
            temp = ar[j];
            ar[j] = ar[2*j+2]; 
            ar[2*j+2] = temp;
            j = 2*j+2;
          }
        }else{
          break;
        }
      }else{
        if (ar[j] < ar[2*j+1]){
          try{
            waitt();
          }catch(Exception e){
            
          }
          temp = ar[j];
          ar[j] = ar[2*j+1]; 
          ar[2*j+1] = temp;
          j = 2*j+1;
        }else{
          break;
        }
      }
    }
  }
}

void quicksort(int arr[], int low, int high) 
{ 
    if (low < high) 
    {
        int pivot = arr[high];  
        int i = (low-1); // index of smaller element 
        for (int j=low; j<high; j++) 
        { 
            // If current element is smaller than the pivot 
            if (arr[j] < pivot) 
            { 
                i++; 
                try{
                  waitt();
                }catch(Exception e){
                  
                }
                // swap arr[i] and arr[j] 
                int temp = arr[i]; 
                arr[i] = arr[j]; 
                arr[j] = temp; 
            } 
        } 
  
        // swap arr[i+1] and arr[high] (or pivot) 
        int temp = arr[i+1]; 
        arr[i+1] = arr[high]; 
        arr[high] = temp; 
  
        int pi = i+1; 
        quicksort(arr, low, pi-1); 
        quicksort(arr, pi+1, high); 
    } 
}

void mergeSort(int a, int b){
  if (a >= b) return;
  mergeSort(a, (a+b)/2);
  mergeSort((a+b)/2+1, b);
  merge(a, (a+b)/2+1, b);
}

void merge(int a, int b, int c){
  int[] temp = new int[n];
  int i = a;
  int j = b;
  int k = a;
  while (i < b && j <= c){
    if (ar[i] < ar[j]){
      temp[k] = ar[i];
      i++;
    }else{
      temp[k] = ar[j];
      j++;
    }
    k++;
  }
  while (i < b){
    temp[k] = ar[i];
    i++;
    k++;
  }
  while (j <= c){
    temp[k] = ar[j];
    j++;
    k++;
  }
  for (int l = a; l <= c; l++) {
    try{
      waitt();
    }catch(Exception e){
      
    }
    ar[l] = temp[l];
  }
}

void waitt(){
  try{  
    Thread.sleep(delay);
  }catch(Exception e){
    
  }
}
