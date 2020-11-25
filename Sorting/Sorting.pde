int[] ar;
int n;
int len;
color[] clr;
Thread prcs;
boolean started = false;
boolean finished = false;
int p1, p2;
int delay;
final color WHITE = color(255, 255, 255);
final color RED = color(255, 0, 0);

boolean f = false;

void setup(){
  surface.setResizable(true);
  surface.setSize(int(displayWidth*0.95), int(displayHeight*0.95));
  surface.setLocation(0, 0);
  len = 8;
  n = width/len;
  p1 = p2 = 0;
  delay = 5;
  ar = new int[n];
  clr = new color[n];
  for (int i = 0; i < n; i++){
    ar[i] = (int) random(1, height);
    clr[i] = WHITE;
  }
  prcs = new Thread(){
    @Override
    public void run(){
      quicksort(ar, 0, n-1);
      //heapSort();
      //mergeSort(0, n-1);
    }
  };
}

void draw(){
  if (!f) return;
  if (prcs.isInterrupted()) return;
  background(0);
  for (int i = 0; i < n; i++){
    fill(clr[i]);
    noStroke();
    rect(i*len, height-ar[i], len, ar[i]);
  }
  if (!started){
    prcs.start();
    started = true;
  }
  if (!prcs.isAlive()){
    if (!finished){
      for (int i = 0; i < delay/10; i++){
      if (p2 != n){
        clr[p2] = color(0, 255, 0);
        p2++;
      }else if (p1 != n){
        clr[p1] = WHITE;
        p1++;
      }else{
        finished = true;
      }
      }
    }
  }
}

void heapSort(){
  for (int i = 1; i < n; i++){
    clr[i] = RED;
    int j = i;
    while (j >= 1){
      if (ar[j] > ar[(j-1)/2]){
        clr[j] = RED;
        try{
          Thread.sleep(delay);
        }catch(Exception e){
        
        }
        int temp = ar[(j-1)/2];
        ar[(j-1)/2] = ar[j]; 
        ar[j] = temp;
        j = (j-1)/2;
        clr[j] = WHITE;
      }else{
        break;
      }
    }
    clr[i] = WHITE;
  }
  for (int i = n-1; i >= 0; i--){
    clr[i] = RED;
    int temp = ar[0];
    ar[0] = ar[i]; 
    ar[i] = temp;
    int j = 0;
    while (2*j + 1 < i){
      if (2*j + 2 < i){
        int mi = max(ar[2*j+1], ar[2*j+2]);
        if (mi > ar[j]){
          if (mi == ar[2*j+1]){
            clr[2*j+2] = RED;
            try{
              Thread.sleep(delay);
            }catch(Exception e){
             
            }
            temp = ar[j];
            ar[j] = ar[2*j+1]; 
            ar[2*j+1] = temp;
            clr[2*j+1] = WHITE;
            j = 2*j+1;
          }else{
            clr[2*j+2] = RED;
            try{
              Thread.sleep(delay);
            }catch(Exception e){
             
            }
            temp = ar[j];
            ar[j] = ar[2*j+2]; 
            ar[2*j+2] = temp;
            clr[2*j+2] = WHITE;
            j = 2*j+2;
          }
        }else{
          break;
        }
      }else{
        if (ar[j] < ar[2*j+1]){
          clr[2*j+1] = RED;
          try{
            Thread.sleep(delay);
          }catch(Exception e){
            
          }
          temp = ar[j];
          ar[j] = ar[2*j+1]; 
          ar[2*j+1] = temp;
          clr[2*j+1] = WHITE;
          j = 2*j+1;
        }else{
          break;
        }
      }
    }
    clr[i] = WHITE;
  }
}
 
void quicksort(int arr[], int low, int high) 
{ 
    if (low < high) 
    { 
        clr[low] = RED;
        clr[high] = RED;
        int pivot = arr[high];  
        int i = (low-1); // index of smaller element 
        for (int j=low; j<high; j++) 
        { 
            // If current element is smaller than the pivot 
            if (arr[j] < pivot) 
            { 
                i++; 
                clr[i] = RED;
                clr[j] = RED;
                try{
                  Thread.sleep(delay);
                }catch(Exception e){
                  
                }
                // swap arr[i] and arr[j] 
                int temp = arr[i]; 
                arr[i] = arr[j]; 
                arr[j] = temp; 
                clr[i] = WHITE;
                clr[j] = WHITE;
            } 
        } 
  
        // swap arr[i+1] and arr[high] (or pivot) 
        int temp = arr[i+1]; 
        arr[i+1] = arr[high]; 
        arr[high] = temp; 
  
        int pi = i+1; 
        quicksort(arr, low, pi-1); 
        quicksort(arr, pi+1, high); 
        clr[low] = WHITE;
        clr[high] = WHITE;
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
  clr[a] = RED;
  clr[c] = RED;
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
    clr[l] = RED;
    try{
      Thread.sleep(delay);
    }catch(Exception e){
      
    }
    ar[l] = temp[l];
    clr[l] = WHITE;
  }
  clr[a] = WHITE;
  clr[c] = WHITE;
}

void mouseClicked(){
  f = true;
}

void onResize(){
  
}
