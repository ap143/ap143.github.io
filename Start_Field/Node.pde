class Node{
  float x;
  float y;
  float z;
  float size;
  float px, py;
  float th;
  float speed;
  
  Node(){
    this.x = random(width);
    this.y = random(height);
    this.z = random(1, 5);
    this.size = random(2, 8);
    th = atan((this.y-height/2)/(this.x-width/2));
    if (this.x==width/2){
      this.x += 1;
    }
    this.speed = sqrt(pow(this.x-width/2, 2)+pow(this.y-height/2, 2))/100;
  }
  
  void show(){
    if (this.x>=width/2){
      this.px = this.x + this.speed*cos(th);
      this.py = this.y + this.speed*sin(th);
    }else{
      this.px = this.x - this.speed*cos(th);
      this.py = this.y - this.speed*sin(th);
    }
    this.speed += 0.5;
    stroke(255);
    line(this.x, this.y, this.px, this.py);
    this.x = px;
    this.y = py;
    
    if (abs(this.x-width/2)>width/2 || abs(this.y-height/2)>height/2){
      this.x = random(width);
      this.y = random(height);
      this.z = random(1, 5);
      this.size = random(2, 8);
      th = atan((this.y-height/2)/(this.x-width/2));
      if (this.x==width/2){
        this.x += 1;
      }
      this.speed = sqrt(pow(this.x-width/2, 2)+pow(this.y-height/2, 2))/100;
    }
    
  }
  
}
