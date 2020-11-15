Wave wave;
boolean pause = false;

void setup(){
  int size = displayWidth/20;
  surface.setSize(size*16, size*9); 
  surface.setLocation(size, size);
  initial();
  frameRate(30);
}

void draw(){
  if (pause) return;
  wave.run();
}

void initial(){
  wave = new Wave(5);
  float fre = 50;
  wave.addSine(50, fre, 0);
  wave.addSine(10, fre/10, 0);
  wave.addSine(-150, fre*2, 0);
  wave.addSine(100, fre/4, 0);
}

void drawBaseLine(){
  stroke(0);
  strokeWeight(0.5);
  line(0, 0, width, 0);
}

void keyPressed(){
  if (keyCode == 32) pause = !pause;
}
