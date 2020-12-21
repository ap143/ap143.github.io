public class Disc{
  float x;
  float y;
  float r;
  float vx, vy;
  color clr;
  boolean selected;
  boolean visible = true;
  public Disc(int x, int y, int r, color clr){
    this.x = x;
    this.y = y;
    this.r = r;
    this.clr = clr;
    selected = false;
  }
  public void show(){
    if (!visible) return;
    fill(0);
    strokeWeight(3);
    stroke(clr);
    circle(x, y, 2*r);
    circle(x, y, 1.6*r);
  }
  public void update(){
    updatePos(x+vx/10, y+vy/10);
    if (vx < 0){
      vx += retard*vx;
      vx = min(vx, 0);
    }else{
      vx += retard*vx;
      vx = max(0, vx);
    }
    if (vy < 0){
      vy += retard*vy;
      vy = min(vy, 0);
    }else{
      vy += retard*vy;
      vy = max(0, vy);
    }
  }
  public void updatePos(float dx, float dy){
    if (dx <= -boxLen/2+r) {
      x = -boxLen/2+r;
      vx = -vx;
    }else if (dx >= boxLen/2-r){
      x = boxLen/2-r;
      vx = -vx;
    }else{
      x = dx;
    }
    if (dy <= -boxLen/2+r) {
      y = -boxLen/2+r;
      vy = -vy;
    }else if (dy >= boxLen/2-r){
      y = boxLen/2-r;
      vy = -vy;
    }else{
      y = dy;
    }
  }
  public boolean contain(float x, float y){
    x -= width/2;
    y -= height/2;
    return dist(x, y, this.x, this.y) < this.r;
  }
}
