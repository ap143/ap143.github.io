float scl;
float t = 0;
boolean f = true;
float len;
float temp;

void setup(){

  size(840, 840);
  scl = 80;
  len = 100;
  temp = scl*PI;
  
  frameRate(20);
}

void draw(){
  if (f) return;
  background(50);
  translate(width/2, height/2);
  scale(1, -1);
  
  circle(0, 0, 20);
  
  drawScale();
  
  drawSpiral();
  
  t = (t + PI/180)%(2*PI);
  
  drawMin();
  
}

void drawMin(){
   strokeWeight(5);
   line(0, 0, 2*len*sin(t*12), 2*len*cos(t*12));
   strokeWeight(2);
}

void drawSpiral(){
  stroke(255);
  strokeWeight(2);
  float px = 0, py = 0;
  for (float i = 0; i < 3*PI/2+0.5; i += 0.005){
    line(px, py, scl*i*cos(i-t), scl*i*sin(i-t));
    px = scl*i*cos(i-t);
    py = scl*i*sin(i-t);
  }
}

void drawScale(){
  pushMatrix();
  scale(1, -1);
  textAlign(CENTER, CENTER);
  textSize(20);
  for (int i = 0; i < 6; i++){
    pushMatrix();
    translate(0, -temp*(i/6.0+0.5));
    rotate(atan(1/(i*PI/6 + PI/3)));
    line(-len/2, 0, -10, 0);
    line(10, 0, len/2, 0);
    popMatrix();
    text(i+1, 0, -temp*(i/6.0+0.5));
    
    pushMatrix();
    translate(0, temp*(i/6.0+0.5));
    rotate(atan(1/(i*PI/6 + PI/3)));
    line(-len/2, 0, -10, 0);
    line(10, 0, len/2, 0);
    popMatrix();
    text(i+7, 0, temp*(i/6.0+0.5));
  }
  popMatrix();
}

void keyPressed(){
  if (keyCode == 32) f = !f;
}
