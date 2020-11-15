float fre;
float sp;
float amp;
boolean paused = false;
float curT = 0;

Wave wave;

void setup(){
  int size = displayWidth/20;
  surface.setSize(size*16, size*9); 
  surface.setLocation(size, size);
  initial();
  frameRate(30);
}

void draw(){
  if (paused) return;
  background(200);
  translate(0, height/2);
  scale(1, -1);
  drawAxes();
  wave.update(curT);
  wave.show();
  curT += 0.1;
}

void initial(){
  fre = 0.2;
  sp = 40;
  amp = 100;
  wave = new Wave(true);
  wave.set(sp);
  //wave.addSquarePulse(200, fre);
  wave.addSine(50, 0, fre, true);
  wave.addSine(50, 0, fre, false);
  wave.addSine(50, 0, fre*2, true);
  wave.addSquare(50, 0, fre/2, true);
}

void drawAxes(){
  strokeWeight(2);
  stroke(0);
  line(0, 0, width, 0);
}

void keyPressed(){
  if (keyCode == 32) paused = !paused; 
}
