class Block{
  float x, y, a;
  
  Block(float x_, float y_, float a_){
    this.x = x_;
    this.y = y_;
    this.a = a_;
  }
  
  void show(){
    fill(200, 50, 50);
    stroke(50);
    rect(this.x-this.a/2, this.y-this.a/2, a, a);
  }
  
}
