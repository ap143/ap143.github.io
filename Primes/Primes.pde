long n;
long cur = 2;
int sc = 10;

void setup(){
  n = 1000000;
  size(1000, 1000);
  frameRate(100);
}

boolean check(long m){
  if (n==2) return true;
  if (m%2==0) return false;
  for (int i = 3; i <= sqrt(m); i++){
    if (m%i==0) return false;
  }
  return true;
}

void draw(){
  translate(width/2, height/2);
  if (cur>n) return;
  if (!check(cur)){
    fill(255, 255, 0);
    stroke(255, 255, 0);
  }else{
    fill(0, 0, 255);
    stroke(0, 0, 255);
  }
  ellipse(cur*cos(cur)/sc, cur*sin(cur)/sc, 1, 1);
  cur++;
}
