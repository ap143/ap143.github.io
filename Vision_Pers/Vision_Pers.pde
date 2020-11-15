float rad;
float x, y;
float t;
float omega;
float total;
float px, py, ang;
boolean f = true;

void setup(){
  size(1000, 1000);
  rad = 200;
  t = 0;
  omega = 0.001;
  total = 64;
}

void draw(){
  update();
  background(0);
  if (f) return;
  translate(width/2, height/2);
  scale(1, -1);
  strokeWeight(4);
  noFill();
  stroke(255, 0, 0);
  circle(0, 0, 4*rad);
  frameRate(60);
  fill(255, 255, 0);
  strokeWeight(2);
  //circle(x, y, 20);
  
  t += omega;
  omega += 0.005;
  stroke(255);
  for (int i = 0; i < total; i++){
    //if (t >= 5*i) {
      px = x + rad*cos(-t + i*2*PI/total);
      py = y + rad*sin(-t + i*2*PI/total);
      //ang = atan(py/px);
      //float wt = min((t-5*i)*2, 2);
      //strokeWeight(wt);
      //stroke(255);
      //line(2*rad*cos(ang), 2*rad*sin(ang), -2*rad*cos(ang), -2*rad*sin(ang));
      strokeWeight(3);
      stroke(0, 0, 255);
      circle(px, py, 15);
    //}
  }
  textSize(20);
  fill(255);
  scale(1, -1);
  textAlign(CENTER, CENTER);
  text("Speed = " + round(omega*60000)/1000.0 + " rad/s", 0, -height/2 + 10);
  text("Angle Travelled = " + round(t*1000)/1000.0 + " rad", 0, -height/2 + 40);
}

void update(){
  x = rad*cos(t);
  y = rad*sin(t);
}

void keyPressed(){
  if (keyCode == 32) f = !f;
}
