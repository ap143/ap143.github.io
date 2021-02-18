import java.util.*;

int n;
int len;
int delay;
boolean f = false;

Queue<int[]> qu;
int[] cur;
boolean[][] maze;
boolean[][] close;
boolean[][] open;
boolean found = false;
Thread thr;
boolean started = false;
int[][][] pi;

void setup(){
  surface.setResizable(true);
  surface.setSize((int) (displayHeight*0.9), (int) (displayHeight*0.9));
  surface.setLocation(10, 10);
  
  len = 1;
  n = width/len;
  
  initial();
  
  thr = new Thread(){
    @Override
    public void run(){
      try{
        Thread.sleep(100);
      }catch(Exception e){
      
      }
      solve();
    }
  };
  
}

void initial(){
  maze = new boolean[n][n];
  close = new boolean[n][n];
  open = new boolean[n][n];
  pi = new int[n][n][2];
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      if (int(random(1, 10)) <= 2){
        maze[i][j] = true;
      }
      close[i][j] = false;
      open[i][j] = false;
      pi[i][j][0] = pi[i][j][1] = -1;
    }
  }
  maze[0][0] = false;
  maze[n-1][n-1] = false;
  qu = new LinkedList<int[]>();
  qu.add(new int[]{0, 0});
  close[0][0] = true;
  open[0][0] = true;
}

void draw(){
  background(255);
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      if (maze[i][j]){
        fill(0); stroke(0);
        rect(i*len, j*len, len, len);
      }
      if (open[i][j] && !found){
        fill(255, 0, 0); stroke(255, 0, 0);
        rect(i*len, j*len, len, len);
      }
    }
  }
  if (found){
    int[] cur = {n-1, n-1};
    fill(0, 0, 255); stroke(0, 0, 255);
    while (true){
      int[] nxt = {pi[cur[0]][cur[1]][0], pi[cur[0]][cur[1]][1]};
      rect(cur[0]*len, cur[1]*len, len, len);
      if (nxt[0] == -1 && nxt[1] == -1) break;
      cur = nxt;
    }
  }
  if (!started){
    thr.start();
    started = true;
  }
}

void solve(){
  while(qu.size() > 0){cur = qu.poll();
  
  for (int i = -1; i <= 1; i++){
    for (int j = -1; j <= 1; j++){
      if (i == 0 && j == 0) continue;
      if (!valid(cur[0]+i, cur[1]+j)) continue;
      qu.add(new int[]{cur[0]+i, cur[1]+j});
      close[cur[0]+i][cur[1]+j] = true;
      open[cur[0]+i][cur[1]+j] = true;
      pi[cur[0]+i][cur[1]+j][0] = cur[0];
      pi[cur[0]+i][cur[1]+j][1] = cur[1];
  
      /*try{
        Thread.sleep(1);
      }catch(Exception e){
      
      }*/
      if (cur[0]+i == n-1 && cur[1]+j == n-1){
        found = true;
        return;
      }
    }
  }
  open[cur[0]][cur[1]] = false;
  }
}

boolean valid(int x, int y){
  if (x < 0 || x >= n || y < 0 || y >= n ) return false;
  if (maze[x][y]) return false;
  if (close[x][y]) return false;
  return true;
}
