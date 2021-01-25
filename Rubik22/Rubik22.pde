import peasy.*;
import java.util.*;
 

final color RED = color(185, 0, 0);
final color GREEN = color(0, 155, 72);
final color BLUE = color(0, 69, 173);
final color ORANGE = color(255, 89, 0);
final color WHITE = color(255, 255, 255);
final color YELLOW = color(255, 213, 0);
final color BLACK = color(0);

final char[] moves = new char[]{'R', 'r', 'L', 'l', 'U', 'u', 'D', 'd', 'F', 'f', 'B', 'b'};

PeasyCam cam;
Face[] faces;
int len;
long time;
Thread thread;
int delay;
boolean start = true;
float theta = -0.03;
State correct;
Map<State, Integer> set;

void setup(){
  size(800, 800, P3D);
  len = 50;
  cam = new PeasyCam(this, 500);
  delay = 0;
  initial();
  //Set<State> temp = new HashSet<State>();
  //temp.add(correct);
  //temp.add(new State(faces, '-', null));
  //System.out.println(temp.size());
  //System.out.println(equalStates(correct, new State(faces, '-', null)));
  //delay = 4;
  thread = new Thread(){
    @Override
    public void run(){
      for (int i = 1; i < 8; i++){
        delay = 0;
        scramble(i);
        delay = 4;
        waitt(2000);
        solve();
        waitt(500);
      }
    }
  };
}

void draw(){
  background(200);
  drawCube();
  if (start){
    start = false;
    thread.start();
  }
}

void scramble(int count){
  for (int i = 0; i < count; i ++){
    move(moves[int(random(0, 11))]);
  }
}

void solve(){
  State ans = bfs();
  StringBuilder res = new StringBuilder();
  while (ans != null){
    res.append(ans.move);
    ans = ans.preState;
  }
  int n = res.length();
  for (int i = n-1; i >= 0; i--){
    move(res.charAt(i));
  }
}

State bfs(){
  Queue<State> qu = new LinkedList<State>();
  set = new HashMap<State, Integer>();
  qu.add(new State(faces, '-', null));
  set.put(qu.peek(), 0);
  if (equalStates(qu.peek(), correct)) return qu.peek();
  State temp, temp2;
  while (!qu.isEmpty()){
    temp = qu.remove();
    //System.out.println(qu.size());
    //faces = temp.faces;
    //waitt(500);
    for (int i = 0; i < 12; i++){
      temp2 = temp.getRotated(moves[i]);
      if (set.containsKey(temp2)) continue;
      if (equalStates(temp2, correct)) return temp2;
      qu.add(temp2);
      set.put(temp2, 0);
    }
  }
  return null;
}

boolean equalStates(State s1, State s2){
  boolean[] bb = new boolean[8];
  for (int i = 0; i < 8; i++) bb[i] = false;
  for (int i = 0; i < 8; i++){
    boolean f = false;
    for (int j = 0; j < 8; j++){
      if (bb[j]) continue;
      if (equalS(s1.faces[i], s2.faces[j])){
        bb[j] = true;
        f = true;
        break;
      }
    }
    if (!f) return false;
  }
  return true;
}

boolean equalS(Face f1, Face f2){
  return f1.x == f2.x && f1.y == f2.y && f1.z == f2.z &&
          f1.colors[0] == f2.colors[0] && f1.colors[1] == f2.colors[1] && f1.colors[2] == f2.colors[2];
}

char getCompliment(char c){
  int x = -1;
  for (int i = 0; i < 12; i++){
    if (moves[i] == c) {
      x = i;
      break;
    }
  }
  if (x%2 == 0) return moves[x+1];
  else return moves[x-1];
}

void initial(){
  faces = new Face[8];
  faces[0] = new Face(1, 1, 1); faces[0].set(BLUE, ORANGE, WHITE);
  faces[1] = new Face(1, 1, -1); faces[1].set(BLUE, ORANGE, YELLOW);
  faces[2] = new Face(1, -1, 1); faces[2].set(BLUE, RED, WHITE);
  faces[3] = new Face(1, -1, -1); faces[3].set(BLUE, RED, YELLOW);
  faces[4] = new Face(-1, 1, 1); faces[4].set(GREEN, ORANGE, WHITE);
  faces[5] = new Face(-1, 1, -1); faces[5].set(GREEN, ORANGE, YELLOW);
  faces[6] = new Face(-1, -1, 1); faces[6].set(GREEN, RED, WHITE);
  faces[7] = new Face(-1, -1, -1); faces[7].set(GREEN, RED, YELLOW);
  correct = new State(faces, '-', null);
}

void move(char a){
  //waitt(delay);
  float rX = 0;
  float rY = 0;
  float rZ = 0;
  if (a == 'R'){
    while (abs(rX) < PI/2){
      rX += theta;
      for (Face f: faces){
        if (f.x != 1) continue;
        f.rotX = rX;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.x != 1) continue;
      f.rotate(1, 0, 0);
    }
  }else if (a == 'r'){
    while (abs(rX) < PI/2){
      rX -= theta;
      for (Face f: faces){
        if (f.x != 1) continue;
        f.rotX = rX;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.x != 1) continue;
      f.rotate(-1, 0, 0);
    }
  }else if (a == 'L'){
    while (abs(rX) < PI/2){
      rX -= theta;
      for (Face f: faces){
        if (f.x != -1) continue;
        f.rotX = rX;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.x != -1) continue;
      f.rotate(-1, 0, 0);
    }
  }else if (a == 'l'){
    while (abs(rX) < PI/2){
      rX += theta;
      for (Face f: faces){
        if (f.x != -1) continue;
        f.rotX = rX;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.x != -1) continue;
      f.rotate(1, 0, 0);
    }
  }else if (a == 'U'){
    while (abs(rY) < PI/2){
      rY += theta;
      for (Face f: faces){
        if (f.y != 1) continue;
        f.rotY = rY;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.y != 1) continue;
      f.rotate(0, 1, 0);
    }
  }else if (a == 'u'){
    while (abs(rY) < PI/2){
      rY -= theta;
      for (Face f: faces){
        if (f.y != 1) continue;
        f.rotY = rY;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.y != 1) continue;
      f.rotate(0, -1, 0);
    }
  }else if (a == 'D'){
    while (abs(rY) < PI/2){
      rY -= theta;
      for (Face f: faces){
        if (f.y != -1) continue;
        f.rotY = rY;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.y != -1) continue;
      f.rotate(0, -1, 0);
    }
  }else if (a == 'd'){
    while (abs(rY) < PI/2){
      rY += theta;
      for (Face f: faces){
        if (f.y != -1) continue;
        f.rotY = rY;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.y != -1) continue;
      f.rotate(0, 1, 0);
    }
  }else if (a == 'F'){
    while (abs(rZ) < PI/2){
      rZ += theta;
      for (Face f: faces){
        if (f.z != 1) continue;
        f.rotZ = rZ;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.z != 1) continue;
      f.rotate(0, 0, 1);
    }
  }else if (a == 'f'){
    while (abs(rZ) < PI/2){
      rZ -= theta;
      for (Face f: faces){
        if (f.z != 1) continue;
        f.rotZ = rZ;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.z != 1) continue;
      f.rotate(0, 0, -1);
    }
  }else if (a == 'B'){
    while (abs(rZ) < PI/2){
      rZ -= theta;
      for (Face f: faces){
        if (f.z != -1) continue;
        f.rotZ = rZ;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.z != -1) continue;
      f.rotate(0, 0, -1);
    }
  }else if (a == 'b'){
    while (abs(rZ) < PI/2){
      rZ += theta;
      for (Face f: faces){
        if (f.z != -1) continue;
        f.rotZ = rZ;
      }
      waitt(delay);
    }
    for (Face f: faces){
      if (f.z != -1) continue;
      f.rotate(0, 0, 1);
    }
  }
}

void drawCube(){
  strokeWeight(3);
  for (Face f: faces){
    f.render();
    //break;
  }
}

void waitt(int delay){
  try{
    Thread.sleep(delay);
  }catch(Exception e){
    
  }
}

void mouseClicked(){
  thread.resume();
}
