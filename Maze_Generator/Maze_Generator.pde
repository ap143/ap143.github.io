int n;
boolean[][] nodes;
boolean[][][] edges;
Thread thread;
int len = 40;
long delay = 50;

void setup(){
  surface.setSize((displayHeight*4/5/len)*len+1, 
                  (displayHeight*4/5/len)*len+1);
  surface.setLocation(displayWidth/2 - width/2, 
                      displayHeight/2 - height/2);
  n = width / len;
  nodes = new boolean[n][n];
  edges = new boolean[n][n][4];
  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
      nodes[i][j] = false;
      edges[i][j] = new boolean[]{false, false, false, false};
    }
  }
  
  thread = new Thread(){
    @Override
    public void run(){
      generate();
    }
  };
  thread.start();
}

void draw(){
  background(37);
  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
      noStroke();
      fill(80, 0, 80);
      // System.out.println(i+" "+j);
      if (nodes[j][i]) rect(i*len, j*len, len, len);
      stroke(255);
      if (!edges[j][i][0]){
        line(i*len, j*len, i*len+len, j*len);
      }
      if (!edges[j][i][1]){
        line(i*len+len, j*len, i*len+len, j*len+len);
      }
      if (!edges[j][i][2]){
        line(i*len, j*len+len, i*len+len, j*len+len);
      }
      if (!edges[j][i][3]){
        line(i*len, j*len, i*len, j*len+len);
      }
    }
  }
  //saveFrame("/temp/save ####.png");
}

void generate(){try{
    Thread.sleep(2000);
  }catch(Exception e){}
  dfs(0, 0);
}

void dfs(int i, int j){
  try{
    Thread.sleep(delay);
  }catch(Exception e){}
  // System.out.println(i+" "+j);
  nodes[i][j] = true;
  ArrayList<Integer> list = new ArrayList<Integer>();
  for (int x = 0; x < 4; x++){
    list.add(x);
  }
  java.util.Collections.shuffle(list);
  for (int x: list){
    int[] next = getNextNode(i, j, x);
    if (isValid(next[0], next[1])){
      edges[i][j][x] = true;
      edges[next[0]][next[1]][(x+2)%4] = true;
      dfs(next[0], next[1]);
    }
  }
}

int[] getNextNode(int i, int j, int e){
  if (e == 0){
    return new int[]{i-1, j};
  }else if (e == 1){
    return new int[]{i, j+1};
  }else if (e == 2){
    return new int[]{i+1, j};
  }else{
    return new int[]{i, j-1};
  }
}

boolean isValid(int i, int j){
  if(i < 0 || j < 0 || i >= n || j >= n){
    return false;
  }else{
    return !nodes[i][j];
  }
}
