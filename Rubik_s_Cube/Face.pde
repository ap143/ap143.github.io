class Face{
  public int x, y, z;
  private int rx, ry, rz;
  private color[] rColors;
  public float rotX, rotY, rotZ;
  color[] colors;
  Face(int x, int y, int z){
    this.rx = x; this.ry = y; this.rz = z;
    this.x = x;
    this.y = y;
    this.z = z;
    this.colors = new color[3];
  }
  boolean check(){
    boolean f =  x == rx && y == ry && z == rz;
    if (!f) return false;
    for (int i = 0; i < 3; i++){
      if (colors[i] != rColors[i]) return false;
    }
    return true;
  }
  boolean checkPosition(){
    return x == rx && y == ry;
  }
  void rotate(int x, int y, int z){
    //if (x != 0){
    //  rotX = 0;
    //  while (abs(rotX) < abs(PI/2*x)){
    //    waitt(delay);
    //    rotX += x*0.1;
    //  }
    //}else if (y != 0){
    //  rotY = 0;
    //  while (abs(rotY) < abs(PI/2*y)){
    //    waitt(delay);
    //    rotY += y*0.1;
    //  }
    //}else{
    //  rotZ = 0;
    //  while (abs(rotZ) < abs(PI/2*z)){
    //    waitt(delay);
    //    rotZ += z*0.1;
    //  }
    //}
    rotX = rotY = rotZ = 0;
    if (x != 0){
      if (x == 1){
        int temp = this.z;
        this.z = -this.y;
        this.y = temp;
      }else{
        int temp = this.y;
        this.y = -this.z;
        this.z = temp;
      }
      color temp = this.colors[1];
      this.colors[1] = this.colors[2];
      this.colors[2] = temp;
    }else if (y != 0){
      if (y == 1){
        int temp = this.x;
        this.x = -this.z;
        this.z = temp;
      }else{
        int temp = this.z;
        this.z = -this.x;
        this.x = temp;
      }
      color temp = this.colors[0];
      this.colors[0] = this.colors[2];
      this.colors[2] = temp;
    }else{
      if (z == -1){
        int temp = this.x;
        this.x = -this.y;
        this.y = temp;
      }else{
        int temp = this.y;
        this.y = -this.x;
        this.x = temp;
      }
      color temp = this.colors[0];
      this.colors[0] = this.colors[1];
      this.colors[1] = temp;   
    }
  }
  void render(){
    pushMatrix();
    float r = len/2.0;
    rotateX(rotX);
    rotateY(rotY);
    rotateZ(rotZ);
    translate(x*len, y*len, z*len);
    if (z != 0){
      fill(colors[2]);
      beginShape(QUADS);
      vertex(r, r, z*r);
      vertex(r, -r, z*r);
      vertex(-r, -r, z*r);
      vertex(-r, r, z*r);
      endShape();
      fill(BLACK);
      beginShape(QUADS);
      vertex(r, r, -z*r);
      vertex(r, -r, -z*r);
      vertex(-r, -r, -z*r);
      vertex(-r, r, -z*r);
      endShape();
    }else{
      fill(BLACK);
      beginShape(QUADS);
      vertex(r, r, r);
      vertex(r, -r, r);
      vertex(-r, -r, r);
      vertex(-r, r, r);
      endShape();
      beginShape(QUADS);
      vertex(r, r, -r);
      vertex(r, -r, -r);
      vertex(-r, -r, -r);
      vertex(-r, r, -r);
      endShape();
    }
    if (x != 0){
      fill(colors[0]);
      beginShape(QUADS);
      vertex(x*r, r, r);
      vertex(x*r, -r, r);
      vertex(x*r, -r, -r);
      vertex(x*r, r, -r);
      endShape();
      fill(BLACK);
      beginShape(QUADS);
      vertex(-x*r, r, r);
      vertex(-x*r, -r, r);
      vertex(-x*r, -r, -r);
      vertex(-x*r, r, -r);
      endShape();
    }else{
      fill(BLACK);
      beginShape(QUADS);
      vertex(r, r, r);
      vertex(r, -r, r);
      vertex(r, -r, -r);
      vertex(r, r, -r);
      endShape();
      beginShape(QUADS);
      vertex(-r, r, r);
      vertex(-r, -r, r);
      vertex(-r, -r, -r);
      vertex(-r, r, -r);
      endShape();
    }
    if (y != 0){
      fill(colors[1]);
      beginShape(QUADS);
      vertex(r, y*r, r);
      vertex(r, y*r, -r);
      vertex(-r, y*r, -r);
      vertex(-r, y*r, r);
      endShape();
      fill(BLACK);
      beginShape(QUADS);
      vertex(r, -y*r, r);
      vertex(r, -y*r, -r);
      vertex(-r, -y*r, -r);
      vertex(-r, -y*r, r);
      endShape();
    }else{
      fill(BLACK);
      beginShape(QUADS);
      vertex(r, r, r);
      vertex(r, r, -r);
      vertex(-r, r, -r);
      vertex(-r, r, r);
      endShape();
      beginShape(QUADS);
      vertex(r, -r, r);
      vertex(r, -r, -r);
      vertex(-r, -r, -r);
      vertex(-r, -r, r);
      endShape();
    }
    popMatrix();
  }
  void set(color c1, color c2, color c3){
    this.colors[0] = c1;
    this.colors[1] = c2;
    this.colors[2] = c3;
    this.rColors = new color[]{c1, c2, c3};
  }
}
