import processing.sound.*;

float len=35;
float lenB = len*2/3;
float keyHeight = 200;
int cur = 0;

SinOsc[] sounds = new SinOsc[88];

void setup(){
  size(1820, 900);
  for (int i = 0; i < 88; i++){
    sounds[i] = new SinOsc(this);
    sounds[i].freq(440*pow(2, (i-48)/2));
  }
  frameRate(2);
  sounds[0].play();
}

void draw(){
  background(0);
  pushMatrix();
  translate(0, height-keyHeight);
  fill(255);
  stroke(0);
  strokeWeight(2);
  for (int i = 0; i < 52; i++){
    rect(i*len, 0, len, keyHeight);
  }
  fill(0);
  rect(len-lenB/2, 0, lenB, keyHeight/2);
  for (int i = 0; i < 7; i++){
    pushMatrix();
    translate(i*7*len+2*len, 0);
    rect(len-lenB/2, 0, lenB, keyHeight/2);
    rect(2*len-lenB/2, 0, lenB, keyHeight/2);
    rect(4*len-lenB/2, 0, lenB, keyHeight/2);
    rect(5*len-lenB/2, 0, lenB, keyHeight/2);
    rect(6*len-lenB/2, 0, lenB, keyHeight/2);
    popMatrix();
  }
  popMatrix();
  sounds[cur].stop();
  cur = (cur+1)%88;
  sounds[cur].play();
}
