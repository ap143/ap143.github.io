final color[] colors = {#ff0000, #ffa500, #ffff00, #008000, #0000ff,
                        #4b0082, #ee82ee};
final boolean[][][] shapes = {};

float len;
int n = 12;
int m = 20;

void setup(){
  size(393, 786);
  len = ((float) width)/n;
}

void draw(){
  background(200);
  translate(0, height);
  scale(1, -1);
  stroke(0);
  strokeWeight(0.3);
  for (int i = 0; i < n; i++){
    line((i+1)*len, 0, (i+1)*len, m*len);
  }
  for (int i = 0; i < m; i++){
    line(0, (i+1)*len, n*len, (i+1)*len);
  }
}
