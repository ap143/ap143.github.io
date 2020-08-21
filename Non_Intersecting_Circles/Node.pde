class Node{
  float x, y, r;
  
  Node(){
    this.x = random(width);
    this.y = random(height);
    this.r = random(10, 50);
    check();
  }
  
  Node(float x_, float y_, float r_){
    this.x = x_;
    this.y = y_;
    this.r = r_;
  }
  
  boolean check(){
    if (this.x<this.r || 
      this.x>width-r ||
      this.y<this.r ||
      this.y>height-r){
      this.x = random(width);
      this.y = random(height);
      this.r = random(10, 50);
      return this.check();
      }else{
      return true;
    }
  }
  
  void show(){
    
    noStroke();
  
    fill(200, 0, 200, 100);
    circle(this.x, this.y, 2*this.r);
  }
  
}
