class Drop {
  
  float z = random(0, 10);
  
  float x = random(0, width);
  float y = random(-600, -50);
  float len = map(z, 0, 10, 5, 30);
  float sp = map(z, 0, 10, 1, 10);
  float grav = map(z, 0, 10, 0.01, 0.05);
  
  void drop(){
    sp += grav;
    y += sp;
    if (y>height){
      y = random(-500, 0);
      x = random(0, width);
      len = map(z, 0, 10, 5, 30);
      sp = map(z, 0, 10, 1, 10);
      grav = map(z, 0, 10, 0.01, 0.05);
    }
  }
  
  void show(){
    strokeWeight(map(z, 0, 10, 1, 4));
    stroke(138, 43, 226);
    line(x, y, x, y+len);
  }
}
