import peasy.*;
import java.util.ArrayList;
 

final color RED = color(185, 0, 0);
final color GREEN = color(0, 155, 72);
final color BLUE = color(0, 69, 173);
final color ORANGE = color(255, 89, 0);
final color WHITE = color(255, 255, 255);
final color YELLOW = color(255, 213, 0);
final color BLACK = color(0);

final char[] moves = new char[]{'R', 'r', 'L', 'l', 'U', 'u', 'D', 'd', 'F', 'f', 'B', 'b'};

final String yellowUP1 = "FRUruf";
final String yellowUP2 = "FURurf";
final String lstMoveR = "RuuruRur";
final String lstMoveL = "lUULUlUL";
final String triMoveR = "RulUruLU";
final String triMoveL = "lURuLUru";
final String lstMove = "RuuruRurlUULUlUL";

PeasyCam cam;
Face[] faces;
int len;
long time;
Thread temp;
int delay;
boolean start = true;
boolean f = false;
float theta = 0.05;

//void mousePressed(){
//  f = false;
//}

void setup(){
  size(800, 800, P3D);
  len = 50;
  cam = new PeasyCam(this, 500);
  delay = 0;
  initial();
  scramble();
  delay = 4;
  temp = new Thread(){
    @Override
    public void run(){
      waitt(2000);
      long time = System.currentTimeMillis();
      solve();
      System.out.println(System.currentTimeMillis()-time);
      waitt(500);
      //scramble();
      //run();
    }
  };
}

void draw(){
  if (f) return;
  background(200);
  drawCube();
  if (start){
    start = false;
    temp.start();
  }
  if (!temp.isAlive()){
    frameRate(0);
  }
}

void scramble(){
  for (int i = 0; i < 50; i ++){
    move(moves[int(random(0, 11))]);
  }
}

void solve(){
  Face temp = null;
  // faces[12] BLUE WHITE CROSS
  if (!faces[12].check()){
    temp = faces[12];
    bringDown(temp);
    color cur = getSideOne(temp.x, temp.y);
    if (cur == ORANGE) seq("b");
    else if (cur == RED) seq("B");
    else if (cur == GREEN) seq("BB");
    if (temp.colors[0] == WHITE) seq("BUdruD");
    else seq("RR");
  }
  // faces[8] ORANGE WHITE CROSS
  if (!faces[8].check()){
    temp = faces[8];
    bringDown(temp);
    color cur = getSideOne(temp.x, temp.y);
    if (cur == GREEN) seq("b");
    else if (cur == BLUE) seq("B");
    else if (cur == RED) seq("BB");
    if (temp.colors[1] == WHITE) seq("BLrulR");
    else seq("UU");
  }
  // faces[14] GREEN WHITE CROSS
  if (!faces[14].check()){
    temp = faces[14];
    bringDown(temp);
    color cur = getSideOne(temp.x, temp.y);
    if (cur == RED) seq("b");
    else if (cur == ORANGE) seq("B");
    else if (cur == BLUE) seq("BB");
    if (temp.colors[0] == WHITE) seq("BuDlUd");
    else seq("LL");
  }
  // faces[10] RED WHITE CROSS
  if (!faces[10].check()){
    temp = faces[10];
    bringDown(temp);
    color cur = getSideOne(temp.x, temp.y);
    if (cur == GREEN) seq("B");
    else if (cur == BLUE) seq("b");
    else if (cur == ORANGE) seq("BB");
    if (temp.colors[1] == WHITE) seq("BlRdLr");
    else seq("DD");
  }
  // faces[0] ORANGE WHITE BLUE
  if (!faces[0].check()){
    temp = faces[0];
    if (temp.z == 1) bringDownC(temp);
    if (temp.x == 1 && temp.y == 1) seq("");
    else if (temp.x == 1 && temp.y == -1) seq("B");
    else if (temp.y == 1) seq("b");
    else seq("BB");
    if (temp.colors[2] == WHITE) seq("uBBUB");
    if (temp.colors[0] == WHITE) seq("RBr");
    else seq("ubU");
  }
  // faces[4] GREEN ORANGE WHITE
  if (!faces[4].check()){
    temp = faces[4];
    if (temp.z == 1) bringDownC(temp);
    if (temp.x == 1 && temp.y == 1) seq("B");
    else if (temp.x == 1 && temp.y == -1) seq("BB");
    else if (temp.y == 1) seq("");
    else seq("b");
    if (temp.colors[2] == WHITE) seq("UBBub");
    if (temp.colors[0] == WHITE) seq("lbL");
    else if (temp.colors[1] == WHITE) seq("UBu");
  }// faces[6] GREEN RED WHITE
  if (!faces[6].check()){
    temp = faces[6];
    if (temp.z == 1) bringDownC(temp);
    if (temp.x == 1 && temp.y == 1) seq("BB");
    else if (temp.x == 1 && temp.y == -1) seq("b");
    else if (temp.y == 1) seq("B");
    else seq("");
    if (temp.colors[2] == WHITE) seq("dBBDB");
    if (temp.colors[0] == WHITE) seq("LBl");
    else seq("dbD");
  }
  // faces[2] BLUE WHITE RED
  if (!faces[2].check()){
    temp = faces[2];
    if (temp.z == 1) bringDownC(temp);
    if (temp.x == 1 && temp.y == 1) seq("b");
    else if (temp.x == 1 && temp.y == -1) seq("");
    else if (temp.y == 1) seq("BB");
    else seq("B");
    if (temp.colors[2] == WHITE) seq("DBBdb");
    if (temp.colors[0] == WHITE) seq("rbR");
    else if (temp.colors[1] == WHITE) seq("DBd");
  }
  // faces[16] ORANGE BLUE SIDE
  if (!faces[16].check()){
    temp = faces[16];
    bringDownSide(temp);
    if (temp.x == 1) seq("");
    else if (temp.x == -1) seq("BB");
    else if (temp.y == 1) seq("b");
    else seq("B");
    if (temp.colors[0] == ORANGE) {
      seq("B");
      seq(convert(ORANGE, getSideMove(false)));
    }else{
      seq(convert(BLUE, getSideMove(true)));
    }
  }
  // faces[18] GREEN ORANGE SIDE
  if (!faces[18].check()){
    temp = faces[18];
    bringDownSide(temp);
    if (temp.x == 1) seq("B");
    else if (temp.x == -1) seq("b");
    else if (temp.y == 1) seq("");
    else seq("BB");
    if (temp.colors[1] == GREEN) {
      seq("B");
      seq(convert(GREEN, getSideMove(false)));
    }else{
      seq(convert(ORANGE, getSideMove(true)));
    }
  }
  // faces[19] GREEN RED SIDE
  if (!faces[19].check()){
    temp = faces[19];
    bringDownSide(temp);
    if (temp.x == 1) seq("BB");
    else if (temp.x == -1) seq("");
    else if (temp.y == 1) seq("B");
    else seq("b");
    if (temp.colors[0] == RED) {
      seq("B");
      seq(convert(RED, getSideMove(false)));
    }else{
      seq(convert(GREEN, getSideMove(true)));
    }
  }
  // faces[17] RED BLUE SIDE
  if (!faces[17].check()){
    temp = faces[17];
    bringDownSide(temp);
    if (temp.x == 1) seq("b");
    else if (temp.x == -1) seq("B");
    else if (temp.y == 1) seq("BB");
    else seq("");
    if (temp.colors[1] == BLUE) {
      seq("B");
      seq(convert(BLUE, getSideMove(false)));
    }else{
      seq(convert(RED, getSideMove(true)));
    }
  }
  
  // =============================TOP LAYER BEGINS==============================
  // 9, 11, 13, 15 ====== YELLOW EDGES
  ArrayList<Face> edges = new ArrayList<Face>();
  Face[] topEdges = {faces[9], faces[11], faces[13], faces[15]};
  for (Face face: topEdges){
    if (face.colors[2] == YELLOW){
      edges.add(face);
    }
  }
  if (edges.size() == 0){
    seq(convert(ORANGE, yellowUP1));
    seq("BB");
    seq(convert(ORANGE, yellowUP2));
  }else if (edges.size() == 2){
    Face f1 = edges.get(0);
    Face f2 = edges.get(1);
    if (f1.x*f2.x == 0 && f1.y*f2.y == 0){
      while (!((f1.x == -1 && f2.y == -1) || 
              (f2.x == -1 && f1.y == -1))){
        seq("B");
      }
      seq(convert(ORANGE, yellowUP2));
    }else{
      while (f1.x*f2.x == 0) seq("B");
      seq(convert(ORANGE, yellowUP1));
    }
  }
  edges.clear();
  while (checkEdge() < 2) seq("B");
  if (checkEdge() == 2){
    for (Face f: topEdges){
      if (f.check()) edges.add(f);
    }
    Face f1 = edges.get(0);
    Face f2 = edges.get(1);
    if (f1.x*f2.x == 0 && f1.y*f2.y == 0){
      while (!((f1.x == -1 && f2.y == -1) || 
              (f2.x == -1 && f1.y == -1))){
        seq("B");
      }
      seq(convert(ORANGE, lstMoveR));
    }else{
      while (f1.x*f2.x == 0) seq("B");
      seq(convert(ORANGE, lstMoveR));
      seq("B");
      seq(convert(ORANGE, lstMoveR));
    }
  }
  while (checkEdge() != 4) seq("B");
  
  // =====================Last Corners=========================
  // 1, 3, 5, 7 === YELLOW CORNERS
  Face[] corners = {faces[1], faces[3], faces[5], faces[7]};
  if (checkCorner() == 0){
    seq(convert(ORANGE, triMoveR));
  }
  if (checkCorner() == 1){
    Face f1 = faces[0];
    for (Face f: corners){
      if (f.checkPosition()){
        f1 = f;
        break;
      }
    }
    color cc;
    if (f1.x == 1 && f1.y == 1){
      cc = ORANGE;
    }else if (f1.x == 1 && f1.y == -1){
      cc = BLUE;
    }else if (f1.y == 1){
      cc = GREEN;
    }else{
      cc = RED;
    }
    while (checkCorner() != 4){
      seq(convert(cc, triMoveL));
    }
  }
  
  // =====================Final=====================
  while(checkLast() == 0){
    seq(convert(ORANGE, lstMove));
  }
  if (checkLast() == 1){
    Face f1 = faces[0];
    for (Face f: corners){
      if (f.check()){
        f1 = f;
        break;
      }
    }
    color cc;
    if (f1.x == 1 && f1.y == 1){
      cc = BLUE;
    }else if (f1.x == 1 && f1.y == -1){
      cc = RED;
    }else if (f1.y == 1){
      cc = ORANGE;
    }else{
      cc = GREEN;
    }
    while (checkLast() == 1){
      seq(convert(cc, lstMove));
    }
  }
  color cc;
  if (checkLast() == 2){
    edges.clear();
    for (Face f: corners){
      if (f.check()) edges.add(f);
    }
    Face f1 = edges.get(0);
    Face f2 = edges.get(1);
    if (f1.x*f2.x == -1 && f1.y*f2.y == -1){
      if (faces[1].colors[2] == YELLOW){
        if (faces[3].colors[0] == YELLOW){
          seq(convert(ORANGE, lstMove));
        }else{
          seq(convert(BLUE, lstMove));
        }
      }else{
        if (faces[1].colors[0] == YELLOW){
          seq(convert(ORANGE, lstMove));
        }else{
          seq(convert(GREEN, lstMove));
        }
      }
    }
    edges.clear();
    for (Face f: corners){
      if (f.check()) edges.add(f);
    }
    f1 = edges.get(0);
    f2 = edges.get(1);
    if (f1.x == f2.x){
      cc = f1.x == 1 ? RED : ORANGE;
    }else{
      cc = f1.y == 1 ? BLUE : GREEN;
    }
    while (checkLast() != 4) seq(convert(cc, lstMove));
  }
  System.out.println("SOLVED");
}

void seq(String s){
  for (int i = 0; i < s.length(); i++){
    move(s.charAt(i));
  }
}

boolean check(){
  for (Face f: faces){
    if (f.z != 1) continue;
    if (f.x*f.y != 0) continue;
    if (!f.check()) return false;
  }
  return true;
}

int checkLast(){
  int i = 0;
  if (faces[1].check()) i++;
  if (faces[3].check()) i++;
  if (faces[5].check()) i++;
  if (faces[7].check()) i++;
  return i;
}

int checkCorner(){
  int i = 0;
  if (faces[1].checkPosition()) i++;
  if (faces[3].checkPosition()) i++;
  if (faces[5].checkPosition()) i++;
  if (faces[7].checkPosition()) i++;
  return i;
}

int checkEdge(){
  int i = 0;
  if (faces[9].check()) i++;
  if (faces[11].check()) i++;
  if (faces[13].check()) i++;
  if (faces[15].check()) i++;
  return i;
}

String getSideMove(boolean right){
  return right ? "ulULUFuf" : "URurufUF";
}

void bringDownSide(Face temp){
  if (temp.z == 0){
    if (temp.x == 1 && temp.y == 1) seq(convert(BLUE, getSideMove(true)));
    else if (temp.x == 1 && temp.y == -1) seq(convert(BLUE ,getSideMove(false)));
    else if (temp.y == 1) seq(convert(ORANGE, getSideMove(true)));
    else seq(convert(GREEN, getSideMove(true)));
  }
}

void bringDownC(Face temp){ // BRING DOWN IN LEVEL 1 CORNER
  if (temp.x == 1 && temp.y == 1) seq("ubUB");
  else if (temp.x == 1 && temp.y == -1) seq("DBdb");
  else if (temp.y == 1) seq("UBub");
  else seq("dbDB");
}

void bringDown(Face temp){ // BRING DOWN IN CROSS
  if (temp.z == 1){
    if (temp.x == 1 && temp.y == 0) seq("RR");
    else if (temp.x == -1 && temp.y == 0) seq("LL");
    else if (temp.x == 0 && temp.y == 1) seq("UU");
    else seq("DD");
  }else if (temp.z == 0){
    if (temp.x == 1 && temp.y == 1) seq("RBr");
    else if (temp.x == 1 && temp.y == -1) seq("rBR");
    else if (temp.y == 1) seq("lBL");
    else seq("LBl");
  }
}

color getSideOne(int x, int y){ // CROSS MAKING
  if (x == 0){
    return y == 1 ? ORANGE : RED;
  }else{
    return x == 1 ? BLUE : GREEN;
  }
}

void initial(){
  faces = new Face[26];
  faces[0] = new Face(1, 1, 1); faces[0].set(BLUE, ORANGE, WHITE);
  faces[1] = new Face(1, 1, -1); faces[1].set(BLUE, ORANGE, YELLOW);
  faces[2] = new Face(1, -1, 1); faces[2].set(BLUE, RED, WHITE);
  faces[3] = new Face(1, -1, -1); faces[3].set(BLUE, RED, YELLOW);
  faces[4] = new Face(-1, 1, 1); faces[4].set(GREEN, ORANGE, WHITE);
  faces[5] = new Face(-1, 1, -1); faces[5].set(GREEN, ORANGE, YELLOW);
  faces[6] = new Face(-1, -1, 1); faces[6].set(GREEN, RED, WHITE);
  faces[7] = new Face(-1, -1, -1); faces[7].set(GREEN, RED, YELLOW);
  
  faces[8] = new Face(0, 1, 1); faces[8].set(BLACK, ORANGE, WHITE);
  faces[9] = new Face(0, 1, -1); faces[9].set(BLACK, ORANGE, YELLOW);
  faces[10] = new Face(0, -1, 1); faces[10].set(BLACK, RED, WHITE);
  faces[11] = new Face(0, -1, -1); faces[11].set(BLACK, RED, YELLOW);
  
  faces[12] = new Face(1, 0, 1); faces[12].set(BLUE, BLACK, WHITE);
  faces[13] = new Face(1, 0, -1); faces[13].set(BLUE, BLACK, YELLOW);
  faces[14] = new Face(-1, 0, 1); faces[14].set(GREEN, BLACK, WHITE);
  faces[15] = new Face(-1, 0, -1); faces[15].set(GREEN, BLACK, YELLOW);
  
  faces[16] = new Face(1, 1, 0); faces[16].set(BLUE, ORANGE, BLACK);
  faces[17] = new Face(1, -1, 0); faces[17].set(BLUE, RED, BLACK);
  faces[18] = new Face(-1, 1, 0); faces[18].set(GREEN, ORANGE, BLACK);
  faces[19] = new Face(-1, -1, 0); faces[19].set(GREEN, RED, BLACK);
  
  //front = new Face[6];
  faces[20] = new Face(0, 0, 1); faces[20].set(BLACK, BLACK, WHITE);
  faces[21] = new Face(1, 0, 0); faces[21].set(BLUE, BLACK, BLACK);
  faces[22] = new Face(-1, 0, 0); faces[22].set(GREEN, BLACK, BLACK);
  faces[23] = new Face(0, 1, 0); faces[23].set(BLACK, ORANGE, BLACK);
  faces[24] = new Face(0, -1, 0); faces[24].set(BLACK, RED, BLACK);
  faces[25] = new Face(0, 0, -1); faces[25].set(BLACK, BLACK, YELLOW);
}

String convert(color c, String s){
  if (c == WHITE) return s;
  StringBuilder res = new StringBuilder();
  if (c == GREEN){
    for (int i = 0; i < s.length(); i++){
      char cc = s.charAt(i);
      char ss = 'a';
      if (cc == 'R') ss = 'U';
      else if (cc == 'r') ss = 'u';
      else if (cc == 'L') ss = 'D';
      else if (cc == 'l') ss = 'd';
      else if (cc == 'F') ss = 'L';
      else if (cc == 'f') ss = 'l';
      else if (cc == 'U') ss = 'B';
      else if (cc == 'u') ss = 'b';
      else if (cc == 'D') ss = 'F';
      else if (cc == 'd') ss = 'f';
      else if (cc == 'B') ss = 'R';
      else if (cc == 'b') ss = 'r';
      res.append(ss);
    }
  }else if (c == BLUE){
    for (int i = 0; i < s.length(); i++){
      char cc = s.charAt(i);
      char ss = 'a';
      if (cc == 'R') ss = 'D';
      else if (cc == 'r') ss = 'd';
      else if (cc == 'L') ss = 'U';
      else if (cc == 'l') ss = 'u';
      else if (cc == 'F') ss = 'R';
      else if (cc == 'f') ss = 'r';
      else if (cc == 'U') ss = 'B';
      else if (cc == 'u') ss = 'b';
      else if (cc == 'D') ss = 'F';
      else if (cc == 'd') ss = 'f';
      else if (cc == 'B') ss = 'L';
      else if (cc == 'b') ss = 'l';
      res.append(ss);
    }
  }else if (c == YELLOW){
    
  }else if (c == RED){
    for (int i = 0; i < s.length(); i++){
      char cc = s.charAt(i);
      char ss = 'a';
      if (cc == 'R') ss = 'L';
      else if (cc == 'r') ss = 'l';
      else if (cc == 'L') ss = 'R';
      else if (cc == 'l') ss = 'r';
      else if (cc == 'F') ss = 'D';
      else if (cc == 'f') ss = 'd';
      else if (cc == 'U') ss = 'B';
      else if (cc == 'u') ss = 'b';
      else if (cc == 'D') ss = 'F';
      else if (cc == 'd') ss = 'f';
      else if (cc == 'B') ss = 'F';
      else if (cc == 'b') ss = 'f';
      res.append(ss);
    }
  }else if (c == ORANGE){
    for (int i = 0; i < s.length(); i++){
      char cc = s.charAt(i);
      char ss = 'a';
      if (cc == 'R') ss = 'R';
      else if (cc == 'r') ss = 'r';
      else if (cc == 'L') ss = 'L';
      else if (cc == 'l') ss = 'l';
      else if (cc == 'F') ss = 'U';
      else if (cc == 'f') ss = 'u';
      else if (cc == 'U') ss = 'B';
      else if (cc == 'u') ss = 'b';
      else if (cc == 'D') ss = 'F';
      else if (cc == 'd') ss = 'f';
      else if (cc == 'B') ss = 'D';
      else if (cc == 'b') ss = 'd';
      res.append(ss);
    }
  }
  return res.toString();
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
  }
}

void waitt(int delay){
  try{
    Thread.sleep(delay);
  }catch(Exception e){
    
  }
}
