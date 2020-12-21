class Bot{
  int mm;
  int nn;
  color cc;
  Bot(int i, int j, color c){
    mm = i;
    nn = j;
    cc = c;
  }
  void move(int y, int x){
    boolean[][] temp = new boolean[m][n];
    int[][][] pre = new int[m][n][2];
    for (int i = 0; i < m; i++) for (int j = 0; j < n; j++){
      temp[i][j] = false;
      pre[i][j] = new int[]{-1, -1};
    }
    Queue<int[]> qu = new LinkedList<int[]>();
    qu.add(new int[]{mm, nn});
    temp[mm][nn] = true;
    boolean found = false;
    while (qu.size()!=0){
      int[] top = qu.remove();
      //rect(top[0]*len, top[1]*len, len, len);
      for (int i = -1; i <= 1; i++){
        for (int j = -1; j <= 1; j++){
          if (i*j != 0) continue;
          if (i == j) continue;
          if (!maze[top[0]+i][top[1]+j] || temp[top[0]+i][top[1]+j]) continue;
          if (top[0]+i == y && top[1]+j == x){
            found = true;
          }
          qu.add(new int[]{top[0]+i, top[1]+j});
          pre[top[0]+i][top[1]+j] = top;
          temp[top[0]+i][top[1]+j] = true;
        }
        if (found) break;
      }
      if (found) break;
    }
    int[] cur = new int[]{y, x};
    //System.out.println(pre[cur[0]][cur[1]][0]);
    if (cur[0] == -1 || cur[1] == -1) return;
    while (pre[cur[0]][cur[1]][0] != mm || pre[cur[0]][cur[1]][1] != nn){
      //rect(cur[0]*len, cur[1]*len, len, len);
      cur = pre[cur[0]][cur[1]];
      //System.out.println(cur[0]+" "+cur[1]);
      if (cur[0] == -1 || cur[1] == -1) return;
    }
    mm = cur[0];
    nn = cur[1];
  }
  void show(){
    fill(cc);
    stroke(cc);
    rect(nn*len, mm*len, len, len);
  }
}
