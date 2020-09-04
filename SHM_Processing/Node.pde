class Node{
  float x;
  float y;
  float v;
  
  Node (float x_, float y_, float v_){
    this.x = x_;
    this.y = y_;
    this.v = v_;
  }
  
  void show(){
    this.y += this.v;
  }
  
}
