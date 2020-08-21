int[] list;
int n;
float len;
int x, y, t;

void setup(){
  size(1600, 900);
  
  n = 100;
  len = width/n;
  
  list = new int[n];
  for (int i = 0; i < n; i++){
    list[i] = (int) random(height);
  }
  
  x = 0;
  y = 0;
  t = n-1;
  
  //frameRate(100);
  //draw();
}

void draw(){
  
  for (int q = 0; q < 20; q++){
    
  
  background(100);
  
  fill(200);
  for (int i = 0; i < n; i++){
    System.out.println(list[i]);
    rect(i*len, height-list[i], len, list[i]);
  }
  
  if (x==n-1){
    textAlign(CENTER);
    fill(200, 0, 0);
    textSize(32);
    text("Sorted", width/2, 40);
    return;
  }
  
  if (list[y]>list[y+1]){
    int temp = list[y];
    list[y] = list[y+1];
    list[y+1] = temp;
  }
  
  y++;
  
  if (y==t){
    y = 0;
    x++;
    t--;
  }
  
  }
  
  
}
