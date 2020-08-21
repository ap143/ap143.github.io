class Node{
  float x;
  float y;
  float th;
  float len;
  float cur;
  float sp;
  float c1, c2, c3;
  
  Node(){
    this.x = width/2;
    this.th = 0;
    this.y = height;
    this.len = 300*random(0.8, 1.2);
    this.cur = 1;
    this.sp = len/60;
    this.c1 = random(0, 255);
    this.c2 = random(0, 255);
    this.c3 = random(0, 255);
  }
  
  Node(float tx, float ty, float tth, float tlen, float tcur, float c1, float c2, float c3){
    this.x = tx;
    this.y = ty;
    this.th = tth;
    this.len = tlen;
    this.cur = tcur;
    this.sp = len/60;
    this.c1 = c1;
    this.c2 = c2;
    this.c3 = c3;
  }
  
  void show(){
    if (this.len<5) return;
    cur += sp;
    stroke(this.c1, this.c2, this.c3);
    line(x, y, x+sp*sin(th), y-sp*cos(th));
  }
  
  Node copy1(){
    Node a = new Node(x+sp*sin(th), y-sp*cos(th), th-PI/6*random(0.5, 1.5), this.len*random(0.4, 0.9), 1, random(0, 255), random(0, 255), random(0, 255));
    return a;
  }
  
  Node copy2(){
    Node a = new Node(x+sp*sin(th), y-sp*cos(th), th+PI/6*random(0.5, 1.5), this.len*random(0.4, 0.9), 1, random(0, 255), random(0, 255), random(0, 255));
    return a;
  }
  
  Node copy3(){
    Node a = new Node(x+sp*sin(th), y-sp*cos(th), th+2*PI/6*random(0.5, 1.5), this.len*random(0.4, 0.9), 1, random(0, 255), random(0, 255), random(0, 255));
    return a;
  }
  
  Node copy4(){
    Node a = new Node(x+sp*sin(th), y-sp*cos(th), th-2*PI/6*random(0.5, 1.5), this.len*random(0.4, 0.9), 1, random(0, 255), random(0, 255), random(0, 255));
    return a;
  }
  
  Node next(){
    return new Node(x+sp*sin(th), y-sp*cos(th), th, this.len, cur, this.c1, this.c2, this.c3);
  }
  
}
