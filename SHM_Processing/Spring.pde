class Spring{
  float len;
  float x;
  float y;
  
  Spring(float x_, float y_, float len_){
    this.len = len_;
    this.x = x_;
    this.y = y_;
  }
  
  void show(){
    stroke(50);
    noFill();
    line(this.x, this.y, this.x+this.len/20, this.y);
    boolean f = true;
    for (int i = 1; i <= 18; i++){
      line(this.x+this.len/20*i,this.y,
        this.x+this.len/20*i+this.len/40, this.y+(f?1:-1)*5);
      line(this.x+this.len/20*i+this.len/40,this.y+(f?1:-1)*5,
        this.x+this.len/20*(i+1), this.y);
      f = !f;
    }
    line(this.x+this.len*(0.95), this.y, this.x+this.len, this.y);
    fill(50);
    ellipse(this.x+this.len, this.y, 10, 10);
  }
  
}
