float th1, th2;
float v1, v2;

void setup(){
  size(400, 400);
  th1 = 0;
  th2 = 0;
  v1 = 0.1;
  v2 = 0.2;
}

void draw(){
  background(200);
  strokeWeight(2);
  stroke(255, 0, 0);
  noFill();
  arc(width/2, height/2, 80, 80, th1, th2);
  th1 += v1;
  th2 += v2;
  if (th2-th1>=2*PI && v2>v1){
    float temp = v2;
    v2 = v1;
    v1 = temp;
  }else if (th2<=th1 && v2<v1){
    float temp = v2;
    v2 = v1;
    v1 = temp;
  }
}
