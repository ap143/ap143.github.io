final color[] colors = {};

float len;
int n = 12;
int m = 20;

void setup(){
  fullScreen();
  len = ((float) width)/n;
}

void draw(){
  background(200);
  translate(0, height);
  scale(1, -1);
  stroke(0);
  strokeWeight(0.5);
  for (int i = 0; i < n; i++){
    line((i+1)*len, 0, (i+1)*len, m*len);
  }
  for (int i = 0; i < m; i++){
    line(0, (i+1)*len, n*len, (i+1)*len);
  }
}
