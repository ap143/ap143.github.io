final color GREEN = color(0,255,0);
final color GREY = color(150, 150, 150);
final color YELLOW = color(255, 255, 0);

int curI, curJ;
int n = 10;
float len = 80;
color[][] colors = new color[n][n];
int[][][] states = new int[n][n][2];
Thread solve;
int time;

void setup(){
  size(800, 800);
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      if (random(1, 10) <= 5) colors[i][j] = color(0);
      else colors[i][j] = GREY;
      states[i][j][0] = states[i][j][1] = -1;
    }
  }
  solve = (new Thread(){
    @Override
    public void run(){
       for (int i = 0; i < n; i++){
         for (int j = 0; j < n; j++){
           time = 0;
           if (colors[i][j] == GREY) dfs(i, j);  
         }
       }
    }
  });
  solve.start();
}

void draw(){
  background(255);
  strokeWeight(2);
  textSize(20);
  textAlign(CENTER, CENTER);
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      fill(colors[i][j]);
      rect(i*len, j*len, len, len);
      fill(0);
      int x = states[i][j][0];
      int y = states[i][j][1];
      if (x == -1) continue;
      if (y == -1){
        text(x, i*len+len/2, j*len+len/2);
      }else{
        text(x+"/"+y, i*len+len/2, j*len+len/2);
      }
    }
  }
}

void dfs(int i, int j){
  curI = i;
  curJ = j;
  try{
    solve.suspend();
  }catch(Exception e){
    
  }
  colors[i][j] = YELLOW;
  states[i][j][0] = time++;
  if (sane(i+1, j)) dfs(i+1, j);
  if (sane(i, j+1)) dfs(i, j+1);
  if (sane(i-1, j)) dfs(i-1, j);
  if (sane(i, j-1)) dfs(i, j-1);
  curI = i;
  curJ = j;
  try{
    solve.suspend();
  }catch(Exception e){
    
  }
  colors[i][j] = GREEN;
  states[i][j][1] = time++;
}

boolean sane(int i, int j){
  if (i < 0 || j < 0 || i>=n || j >= n) return false;
  return colors[i][j] == GREY;
}

void mouseClicked(){
  if (curI*len < mouseX && (curI+1)*len > mouseX &&
  curJ*len < mouseY && (curJ+1)*len > mouseY)solve.resume();
}
