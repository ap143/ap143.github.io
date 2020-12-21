import java.util.*;

enum MARK{
  E, X, O;
};

float len;
float del = 20;
MARK[][] data = new MARK[3][3];
boolean player = false;
boolean chance = true;
int left;
Set<MARK[][]> set = new HashSet<MARK[][]>();
boolean finish = false;
boolean active = true;

void setup(){
  fullScreen();
  len = width/3;
  for (int i = 0; i < 3; i++){
    for (int j = 0; j < 3; j++){
      data[i][j] = MARK.E;
    }
  }
  left = 9;
}

void draw(){
  background(0);
  translate(0, (height-width)/2);
  strokeWeight(5);
  stroke(255);
  noFill();
  for (int i = 0; i < 2; i++){
    line((i+1)*width/3, del, (i+1)*width/3, width-del);
  }
  for (int i = 0; i < 2; i++){
    line(del, (i+1)*width/3, width-del, (i+1)*width/3);
  }
  for (int i = 0; i < 3; i++){
    for (int j = 0; j < 3; j++){
      if (data[i][j] == MARK.X){
        drawX(j, i);
      }else if (data[i][j] == MARK.O){
        drawO(j, i);
      }
    }
  }
  MARK a = check(data);
  if (a == null && left != 0) {
    if (player == chance) {
      nextMove(data, left, true);
    }
    return;
  }
  if (active){
    active = false;
  }
  textAlign(CENTER, CENTER);
  textSize(20);
  fill(255);
  text("Tap to continue!", width/2, 5*width/4);
  textSize(50);
  if (left == 0 && a == null){
    fill(255, 255, 0);
    text("Draw!", width/2, -width/4);
    return;
  }
  if ((player && left%2 == 0) || (!player && left%2 != 0)){
    fill(255, 0, 0);
    text("LOL, you lost!", width/2, -width/4);
  }else{
    fill(0, 255, 0);
    text("Cool, you won!", width/2, -width/4);
  }
}

int[] nextMove(MARK[][] dt, int lt, boolean main){
  //System.out.println(lt+" "+main);
  ArrayList<Integer> scores = new ArrayList<Integer>();
  ArrayList<int[]> move = new ArrayList<int[]>();
  MARK c;
  if (lt%2==1) c = MARK.X;
  else c = MARK.O;
  for (int i = 0; i < 3; i++){
    for (int j = 0; j < 3; j++){
      if (dt[i][j] != MARK.E) continue;
      MARK[][] temp = copyy(dt);
      temp[i][j] = c;
      MARK a = check(temp);
      int tScr = 0;
      if (lt == 1){
        if (a == null){
          tScr = 0;
        }else if (a == c){
          tScr = 1;
        }else{
          tScr = -1;
        }
      }else{
        if (a == null){
          int[] nxt = nextMove(temp, lt-1, false);
          tScr = -nxt[2];
        }else if (a == c){
          tScr = 1;
        }else{
          tScr = -1;
        }
      }
      scores.add(tScr);
      move.add(new int[]{i, j});
    }
  }
  int mx = scores.get(0);
  int res = 0;
  for (int i = 0; i < scores.size(); i++){
    if (main) System.out.println(move.get(i)[0]+", "+move.get(i)[1]+" = "+scores.get(i));
    if (scores.get(i) > mx){
      res = i;
      mx = scores.get(i);
    }
  }
  if (main){dt[move.get(res)[0]][move.get(res)[1]] = c;
  left--;
  chance = !chance;}
  return new int[]{move.get(res)[0], move.get(res)[1], mx};
}

int fact(int n){
  if (n <= 0) return 1;
  int ans = 1;
  for (int i = 1; i <= n; i++){
    ans *= i;
  }
  return ans;
}

boolean compare(int[] a, int[] b){
  if (a[0] == b[0]){
    if (a[1] == b[1]){
      return a[2] > b[2];
    }else{
      return a[1] > b[1];
    }
  }else{
     return a[0] > b[0];
  }
}

MARK[][] copyy(MARK[][] data){
  MARK[][] temp = new MARK[3][3];
        for (int i = 0; i < 3; i++) for (int j = 0; j < 3; j++) temp[i][j] = data[i][j];
  return temp;
}

void drawO(int x, int y){
  pushMatrix();
  strokeWeight(10);
  stroke(100, 100, 255, 150);
  translate(len*x+len/2, len*y+len/2);
  circle(0, 0, len-del);
  strokeWeight(3);
  stroke(255, 255, 255, 255);
  circle(0, 0, len-del);
  popMatrix();
}

void drawX(int x, int y){
  pushMatrix();
  translate(len*x+len/2, len*y+len/2);
  strokeWeight(10);
  stroke(255, 20, 147, 150);
  for (int i = -1; i <= 1; i += 2){
    for (int j = -1; j <= 1; j += 2){
      line(0, 0, (len/2-del)*i, (len/2-del)*j);
    }
  }
  strokeWeight(3);
  stroke(255, 255, 255, 255);
  for (int i = -1; i <= 1; i += 2){
    for (int j = -1; j <= 1; j += 2){
      line(0, 0, (len/2-del)*i, (len/2-del)*j);
    }
  }
  popMatrix();
}

MARK check(MARK[][] data){
  for (int i = 0; i < 3; i++){
    if (data[i][0] == data[i][1] && data[i][1] == data[i][2] && data[i][0] != MARK.E) return data[i][0];
    if (data[0][i] == data[1][i] && data[1][i] == data[2][i] && data[0][i] != MARK.E) return data[0][i];
  }
  if (data[0][0] == data[1][1] && data[0][0] == data[2][2] && data[1][1] != MARK.E) return data[1][1];
  if (data[0][2] == data[1][1] && data[1][1] == data[2][0] && data[1][1] != MARK.E) return data[1][1];
  return null;
}

void touchStarted(){
  if (!active) {
    active = true;
    player = !player;
    for (int i = 0; i < 3; i++){
      for (int j = 0; j < 3; j++){
        data[i][j] = MARK.E;
      }
    }
    left = 9;
    chance = true;
    return;
  }
  if (player == chance) return;
  int i = (int) ((touches[0].y-(height-width)/2)/len);
  int j = (int) (touches[0].x/len);
  if (i < 0 || i > 2) return;
  if (data[i][j] != MARK.E) return;
  data[i][j] = chance ? MARK.X : MARK.O;
  chance = !chance;
  left--;
}
