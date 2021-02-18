float jump = 2;
int total = 1000;
int pitch = 1000000;
int n = pitch*total;
int r = 0;
int c = 0;
int c2 = 0;
int ind = 2;
boolean[] ar = new boolean[n+1];
int maxx = 0;
void setup(){
  fullScreen();
  surface.setResizable(true);
  background(50);
  stroke(255, 0, 0);
  strokeWeight(2);
  fill(220);
  frameRate(60);
  setAr();
}

void draw(){
  if (ind>=n) return;
  for (int i = 0; i < pitch; i++){
    if (ind>=n) return;
  if (!ar[ind]){
    c++;
  }
  
  if (ind%pitch==0){
    circle(r*jump, height-c/100, 2);
    //dR(r*jump, c*1000);
    //if (c2>maxx){
    //  maxx = c2;
    //  fill(0, 0, 255);
    //  circle(r*jump+jump/2, height-c2/6, 10);
    //  fill(220);
    //}
    //c2 = 0;
    r++;
    c=0;
  }
  ind++;
  //c2++;
  }
}

void dR(float x, float y){
  rect(x+jump/5, height-y, jump*0.6, y); 
}

void setAr(){
  ar[0] = true;
  ar[1] = true;
  for (int i = 2; i <= n; i++){
    if (ar[i]) continue;
    for (int j = 2*i; j <= n; j += i){
      ar[j] = true;
    }
  }
}
