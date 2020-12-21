class Ball{
  float x, y, r;
  float vx, vy;
  color clr;
  int count = 0;
  Ball(float x, float y, float r, color clr){
    this.x = x;
    this.y = y;
    this.r = r;
    this.clr = clr;
  }
  void set(float x, float y){
    vx = x;
    vy = y;
  }
  void show(){
    fill(clr);
    stroke(0);
    strokeWeight(2);
    circle(x, y, 2*r);
  }
  void update(){
    x += vx;
    y += vy;
    vy += g*dt;
    if ((vx > 0 && x+r>=width) || (vx < 0 && x-r <= 0)) vx = -4*vx/5;
    if (y+r >= height && vy > 0){
      vy = -4*vy/5;
      collide(this);
    }else{
      tempQueue.add(this);
    }
  }
}
