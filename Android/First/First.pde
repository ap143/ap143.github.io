final color BGCOLOR = color(0);
final color BOARD_BORDER_COLOR = color(255, 255, 0);
final color BOARD_IN_COLOR = color(0);
final color DISC_BORDER_COLOR = color(255);

final int mainDiscRad = 50;
final float retard = -0.001;
final Disc mainDisc = new Disc(0, 0, mainDiscRad, DISC_BORDER_COLOR);
float px, py;
float boxLen;
Disc[] balls;

void setup(){
  fullScreen();
  init();
}

void init(){
  boxLen = width-20;
  balls = new Disc[14];
  for (int i = 0; i < balls.length; i++){
    
  }
}

void draw(){
  background(0);
  translate(width/2, height/2);
  makeBoard();
  mainDisc.show();
  update();
}

void update(){
  mainDisc.update();
}

void makeBoard(){
  noFill();
  stroke(BOARD_BORDER_COLOR);
  strokeWeight(3);
  square(-width/2, -height/4, width);
  square(-width/2+10, -height/4+10, width-20);
}

boolean checkDisc(Disc a, Disc b){
  if (!a.visible || !b.visible) return false;
  float dist = dist(a.x, a.y, b.x, b.y);
  if (dist < a.r+b.r) return true;
  else return false;
}

void touchStarted(){
  if (mainDisc.contain(touches[0].x,touches[0].y)){
    mainDisc.vx = touches[0].x - mainDisc.x - width/2;
    mainDisc.vy = touches[0].y - mainDisc.y - height/2;
    mainDisc.selected = true;
  }
}

void touchMoved(){
  if (mainDisc.selected){
    mainDisc.vx = touches[0].x - mainDisc.x - width/2;
    mainDisc.vy = touches[0].y - mainDisc.y - height/2;
  }
}

void touchEnded(){
  mainDisc.selected = false;
}
