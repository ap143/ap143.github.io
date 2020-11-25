import java.util.*;

int len;
int n;
boolean[][] maze;
Set<Pointt> closed;
Set<Pointt> open;
Thread solve;
int delay;
boolean started = false;
boolean solved = false;
Pointt[][] points;

int[][][] help;
int[] end;

long[][] fV;
long[][] hV;

boolean f = true;
boolean reached = false;

void setup(){
  len = 2;
  n = 500; System.out.println(n);
  surface.setResizable(true);
  surface.setSize(n*len, n*len);
  surface.setLocation(0, 0);
  delay = 1;
  initialize();
  solve = new Thread(){
    @Override
    public void run(){
      try{
        Thread.sleep(2000);
      }catch(Exception e){
      }
      a_star();
    }
  };
  //a_star();
}

void draw(){
  
  if (f) return;
  
  background(255);
  
  stroke(0);
  fill(0);
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      if (maze[i][j]){
        rect(i*len, j*len, len, len);
      }
      
    }
  }
  
  int hi = end[0], hj = end[1];
  fill(150, 0, 150);
  //noFill();
  stroke(150, 0, 150);
  if (reached){
    fill(0, 255, 0);
    stroke(0, 255, 0);
  }
  noFill();
  strokeWeight(len);
  beginShape();
  while (hi != -1 && hj != -1){
    vertex(hi*len+len/2, hj*len+len/2);
    //rect(hi*len, hj*len, len, len);
    int ti = help[hi][hj][0];
    int tj = help[hi][hj][1];
    hi = ti;
    hj = tj;
  }
  endShape();
  strokeWeight(1);
  if (!started){
    solve.start();
    started = true;
  }

}

void initialize(){
  maze = new boolean[n][n];
  open = new HashSet<Pointt>();
  closed = new HashSet<Pointt>();
  fV = new long[n][n];
  hV = new long[n][n];
  help = new int[n][n][2];
  points = new Pointt[n][n];
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      maze[i][j] = false;
      if (random(1, 10) <= 3){
        maze[i][j] = true;
      }
      fV[i][j] = -1;
      hV[i][j] = -1;
      help[i][j][0] = help[i][j][1] = -1;
      points[i][j] = new Pointt(i, j);
    }
  }
  maze[0][0] = false;
  maze[n-1][n-1] = false;
  end = new int[2];
}

void waitt(){
  
    try{
      Thread.sleep(delay);
    }catch(Exception e){
    
    }
}

void a_star(){
  
  open.add(points[0][0]);
  hV[0][0] = Long.MAX_VALUE-1;
  fV[0][0] = Long.MAX_VALUE-1; 
  end[0] = 0;
  end[1] = 0;
  
  while (true){
    
    waitt();
    
    int mi = 0, mj = 0;
    
    long tCost = Long.MAX_VALUE;
    long tHCost = Long.MAX_VALUE;
    
    for (Pointt p: open){
      int i = p.x;
      int j = p.y;
      if (fV[i][j] < tCost){
        tCost = fV[i][j];
        tHCost = hV[i][j];
        mi = i;
        mj = j;
      }else if (fV[i][j] == tCost){
        if (hV[i][j] < tHCost){
          mi = i;
          mj = j;
          tHCost = hV[i][j];
        }
      }
    }
    
    end[0] = mi;
    end[1] = mj;
    
    open.remove(points[mi][mj]);
    closed.add(points[mi][mj]);
    
    if (mi == n-1 && mj == n-1) {
      reached = true;
      return;
    }
    
    for (int i = -1; i <= 1; i++){
      for (int j = -1; j <= 1; j++){
        //if (!(abs(i) == abs(j))) continue;
        if (i == 0 && j == 0) continue;
        if (!isValid(mi+i, mj+j)) continue;
        int ni = mi+i;
        int nj = mj+j;
        if (closed.contains(points[ni][nj])) continue;
        long resH = getH(ni, nj);
        long resG = fV[mi][mj]-hV[mi][mj] + getG(ni, nj, mi, mj);
        long resF = resH+resG;
        open.add(points[ni][nj]);
        hV[ni][nj] = resH;
        fV[ni][nj] = resF;
        help[ni][nj][0] = mi;
        help[ni][nj][1] = mj;
      }
    }
    
  }
}

long getH(int x, int y){
  return int(10*dist(x, y, n-1, n-1));
}

long getG(int x, int y, int px, int py){
  return int(10*dist(x, y, px, py));
}

boolean isValid(int x, int y){
  if (x < 0 || y < 0 || x >= n || y >= n) return false;
  if (maze[x][y]) return false;
  return true;
}

void mouseClicked(){
  f = false;
}

/*void dfs(int x, int y, int px, int py){
  if (solved) return;
  if (x == n-1 && y == n-1){
    solved = true;
    vstd[x][y] = true;
    return;
  }
  vstd[x][y] = true;
  try{
    Thread.sleep(delay);
  }catch(Exception e){
    
  }
  if (x-1 >= 0){
    if (!maze[x-1][y] && (x-1 != px || y != py)
        && !vstd[x-1][y]) dfs(x-1, y, x, y);
  }
  if (x+1 < n){
    if (!maze[x+1][y] && (x+1 != px || y != py)
        && !vstd[x+1][y]) dfs(x+1, y, x, y);
  }
  if (y-1 >= 0){
    if (!maze[x][y-1] && (x != px || y-1 != py)
        && !vstd[x][y-1]) dfs(x, y-1, x, y);
  }
  if (y+1 < n){
    if (!maze[x][y+1] && (x != px || y+1 != py)
        && !vstd[x][y+1]) dfs(x, y+1, x, y);
  }
  if (solved) return;
  vstd[x][y] = false;
}*/

class Pointt{
  int x, y;
  public Pointt(int x, int y){
    this.x = x;
    this.y = y;
  }
  @Override
  public boolean equals(Object other){
      if (other instanceof Pointt){
        Pointt temp = (Pointt) other;
        return temp.x == this.x && temp.y == this.y;
      }
      return false;
  }
}
