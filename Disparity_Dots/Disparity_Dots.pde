import java.util.*;

int r = 300;
int[] ar;
int n;
int del = 3;
Thread thread, thread2;
int delay = 1;
color[] clrs;
float tx, ty;
float sx, sy;

void setup(){
  size(900, 900);
  tx = ty = 0;
  sx = sy = 1;
  n = 360*del;
  ar = new int[n];
  mix();
  initial();
  thread = new Thread(){
    @Override
    public void run(){
      insertionSort();
      //bubbleSort();
      //mergeSort(0, n-1);
      //heapSort();
      //quicksort(ar, 0, n-1);
      //radixSort(4);
    }
  };
  thread2 = new Thread(){
    @Override
    public void run(){
      //mergeSort(0, n-1);
      //heapSort();
      //quicksort(ar, 0, n-1);
      //radixSort(4);
    }
  };
}

void draw(){
  background(0);
  translate(-tx*sx, -ty*sy);
  scale(sx, sy);
  //translate(-tx, -ty);
  translate(width/2, height/2);
  scale(1, 0.5);
  stroke(255);
  strokeWeight(3);
  for (int i = 0; i < n; i++){
    int tr = (int) (n-(abs(ar[i]-i)*(n/(float) (max(i, n-i))))-1);
    tr = (tr*r)/n;
    stroke(clrs[ar[i]]);
    line(0, 0, tr*cos(radians(((float)i)/del)), tr*sin(radians(((float)i)/del)));
  }
}

void mix(){
  ArrayList<Integer> temp = new ArrayList<Integer>();
  for (int i = 0; i < n; i++){
    temp.add(i);
  }
  Collections.shuffle(temp);
  for (int i = 0; i < n; i++){
    ar[i] = temp.get(i);
  }
}

void initial(){
  clrs = new color[n];
  float d = (n/3)/255.0;
  float r = 0;
  float g = 0;
  float b = 255;
  for (int i = 0; i < n/3; i++){
    clrs[i] = color(r, g, b);
    b -= d;
    g += d;
  }
  for (int i = n/3; i < 2*n/3; i++){
    clrs[i] = color(r, g, b);
    g -= d;
    r += d;
  }
  for (int i = 2*n/3; i < n; i++){
    clrs[i] = color(r, g, b);
    r -= d;
    b += d;
  }
}

void insertionSort(){
  for (int i = 1; i < n; i++){
    int j = i;
    while (j > 0){
      waitt();
      if (ar[j] < ar[j-1]){
        int temp = ar[j];
        ar[j] = ar[j-1];
        ar[j-1] = temp;
        j--;
      }else{
        break;
      }
    }
  }
}

void bubbleSort(){
  for (int i = 0; i < n; i++){
    for (int j = n-1; j > i; j--){
      if (ar[j]<ar[i]){
        int temp = ar[j];
        ar[j] = ar[i];
        ar[i] = temp;
        waitt();
      }
    }
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

void mouseClicked(){
  thread.start();
  thread2.start();
}

void mouseWheel(MouseEvent event){
  int cc = event.getCount();
  if (cc == 0) return;
  float psx = sx;
  float psy = sy;
  if (cc < 0){
    sx *= abs(cc-1);
    sy *= abs(cc-1);
  }else{
    sx /= abs(cc+1);
    sy /= abs(cc+1);
  }
  if (sx <= 0.01){
    sx = sy = 0.01;
  }
  tx += ((mouseX+tx)/psx)*(sx-psx);
  ty += ((mouseY+ty)/psy)*(sy-psy);
  System.out.println(tx);
}
