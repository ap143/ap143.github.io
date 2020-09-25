class Vector{
  
  float th;
  float r;
  boolean active;
  
  float arrowAngle = 0.7;
  
  Vector(){
      
  }
  
  Vector(float r, float th){
    this.r = r;
    this.th = th;
    active = true;
  }
  
  void show(){
    push();
    strokeWeight(1.5);
    line(0, 0, this.r*cos(this.th)*scl, this.r*sin(this.th)*scl);
    line(this.r*cos(this.th)*scl, this.r*sin(this.th)*scl, 
        this.r*cos(this.th)*scl-scl*cos(this.th-arrowAngle), this.r*sin(this.th)*scl-scl*sin(this.th-arrowAngle));
    line(this.r*cos(this.th)*scl, this.r*sin(this.th)*scl, 
        this.r*cos(this.th)*scl-scl*cos(this.th+arrowAngle), this.r*sin(this.th)*scl-scl*sin(this.th+arrowAngle));
    pop();
  }
}
