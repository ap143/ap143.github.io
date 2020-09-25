class Line extends Curve implements CurveInterface{
  
  String a1, b1, c1;
  
  Line(){
    super();
  }
  
  Line(float x1, float y1, float x2, float y2){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.active = true;
    this.c = color(20, 20, 20);
  }
  
  void show(){
    if (this.active){
      stroke(255, 255, 0);
      strokeWeight(2);
    }else{
      strokeWeight(1);
      stroke(20);
    }
    if (this.x1==this.x2){
      line(this.x1, -height/2, this.x1, height/2);
    }else{
      float slope = atan((this.y2-this.y1)/(this.x2- this.x1));
      float lenn = sqrt(width*width + height*height);
      line(this.x1, this.y1, this.x1 + lenn*cos(slope), this.y1 + lenn*sin(slope));
      line(this.x1, this.y1, this.x1 - lenn*cos(slope), this.y1 - lenn*sin(slope));
    }
    strokeWeight(1);
    if (this.active){
      fill(200, 0, 0);
      stroke(255, 0, 0);
      circle(this.x1, this.y1, 5);
      circle(this.x2, this.y2, 5);
      this.writeEquation();
    }
  }
  
  void writeEquation(){
    float aa = this.y1-this.y2;
    float bb = this.x2-this.x1;
    float cc = (this.y2-this.y1)*this.x1-this.y1*(this.x2-this.x1);
    float gg = min(aa==0?Float.MAX_VALUE:abs(aa), bb==0?Float.MAX_VALUE:abs(bb), cc==0?Float.MAX_VALUE:abs(cc));
    this.a1 = String.format("%.2f", aa/gg);
    this.b1 = String.format("%.2f", bb/gg);
    this.c1 = String.format("%.2f", cc/gg);
    pushMatrix();
    textAlign(CENTER, BOTTOM);
    textSize(15);
    fill(20, 20, 255);
    translate((this.x1+this.x2)/2, (this.y1+this.y2)/2);
    rotate(atan((this.y2-this.y1)/(this.x2- this.x1)));
    scale(1, -1);
    text(a1+"x + "+b1+"y + "+c1+" = 0", 0, 0);
    popMatrix();
  }
  
  void intersection(Curve other){
    if (other.x1 == other.x2){
      if (this.x1 == this.x2) return;
      float xx = other.x1;
      float slope = ((this.y2-this.y1)/(this.x2- this.x1));
      float yy = this.y1 + slope*(xx-this.x1);
      fill(0, 200, 0);
      stroke(0, 200, 0);
      circle(xx, yy, 5);
    }else{
      if (this.x1 == this.x2){
        float xx = this.x1;
        float slope = ((other.y2-other.y1)/(other.x2- other.x1));
        float yy = other.y1 + slope*(xx-other.x1);
        fill(0, 200, 0);
        stroke(0, 200, 0);
        circle(xx, yy, 5);
      }else{
        if (((other.y2-other.y1)/(other.x2- other.x1)) == 
            ((this.y2-this.y1)/(this.x2- this.x1)) ) return;
        float xx = (this.x1*this.y2-this.y1*this.x2)*(other.x1-other.x2);
        xx -= (other.x1*other.y2-other.y1*other.x2)*(this.x1-this.x2);
        xx /= ((this.x1-this.x2)*(other.y1-other.y2) - (this.y1-this.y2)*(other.x1-other.x2));
        float yy  = (this.x1*this.y2-this.y1*this.x2)*(other.y1-other.y2);
        yy -= (other.x1*other.y2-other.y1*other.x2)*(this.y1-this.y2);
        yy /= ((this.x1-this.x2)*(other.y1-other.y2) - (this.y1-this.y2)*(other.x1-other.x2)); 
        fill(0, 200, 0);
        stroke(0, 200, 0);
        circle(xx, yy, 5);
      }
    }
  }
  
  boolean check(float x, float y){
    float dist = abs((this.y2-this.y1)*x - (this.x2-this.x1)*y + this.x2*this.y1 - this.y2*this.x1);
    dist /= sqrt(pow(this.y2-this.y1, 2)+pow(this.x2-this.x1, 2));
    return dist <= 4;
  }
  
}
