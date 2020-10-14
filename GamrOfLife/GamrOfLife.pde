int x, y;
final int scale = 20;

boolean[][] ar;

void setup(){
  this.x = 40;
  this.y = 40;
  
  size(800, 800);
  
  ar = new boolean[x][y];
  
  for (int i = 0; i < x; i++){
    for (int j = 0; j < y; j++){
      ar[i][j] = false;
    }
  }
  
  initial();
  
  frameRate(8);
  
}

void draw(){
  background(200);
  
  drawGrids();
  
  drawPoints();
  
  update();
}

void drawGrids(){
  stroke(50);
  for (int i = 0; i < this.x; i++){
    line(0, i*scale, width, i*scale);
  }
  for (int i = 0; i < this.y; i++){
    line(i*scale, 0, i*scale, height);
  }
}

void drawPoints(){
  fill(255, 255, 0);
  stroke(255, 0, 0);
  for (int i = 0; i < x; i++){
    for (int j = 0; j < y; j++){
      if (ar[i][j]){
        rect(j*scale, i*scale, scale, scale);
      }
    }
  }
}

void initial(){
  int[][] pt = {
    {1, 0},
    {2, 1},
    {2, 2},
    {1, 2},
    {0, 2} 
  };
  for (int i = 0; i < pt.length; i++){
    ar[pt[i][0]][pt[i][1]] = true;
  }
}

int count(int i, int j){
  int res = 0;
  if (i-1>=0 && j-1>=0){
    if (ar[i-1][j-1]) res++;
  }
  if (i-1>=0){
    if (ar[i-1][j]) res++;
  }
  if (i-1>=0 && j+1<this.y){
    if (ar[i-1][j+1]) res++;
  }
  if (j-1>=0){
    if (ar[i][j-1]) res++;
  }
  if (j+1<this.y){
    if (ar[i][j+1]) res++;
  }
  if (i+1<this.x && j-1>=0){
    if (ar[i+1][j-1]) res++;
  }
  if (i+1<this.x){
    if (ar[i+1][j]) res++;
  }
  if (i+1<this.x && j+1<this.y){
    if (ar[i+1][j+1]) res++;
  }
  
  return res;
}

void update(){
  boolean[][] temp = new boolean[this.x][this.y];
  for (int i = 0; i < x; i++){
    for (int j = 0; j < y; j++){
      temp[i][j] = ar[i][j];
    }
  }
  for (int i = 0; i < x; i++){
    for (int j = 0; j < y; j++){
      int res = count(i, j);
      if (res>0){
        System.out.println(i+" "+j+" "+res);
      }
      if (res<2 && ar[i][j]){
        temp[i][j] = false;
      }else if (res<=3&&res>=2&&ar[i][j]){
        continue;
      }else if (ar[i][j]&&res>3){
        temp[i][j] = false;
      }else if (!ar[i][j]&&res==3){
        temp[i][j] = true;
      }
    }
  }
  for (int i = 0; i < x; i++){
    for (int j = 0; j < y; j++){
      ar[i][j] = temp[i][j];
    }
  }
}
