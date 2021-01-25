class Face{
  public int x, y, z;
  public float rotX, rotY, rotZ;
  color[] colors;
  color[] rClr;
  public int rx, ry, rz;
  Face(int x, int y, int z){
    this.x = x;
    this.y = y;
    this.z = z;
    rx = x;
    ry = y;
    rz = z;
    this.colors = new color[3];
    rClr = new color[3];
  }
  void rotate(int x, int y, int z){
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
    translate(x*len/2, y*len/2, z*len/2);
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
    popMatrix();
  }
  void set(color c1, color c2, color c3){
    this.colors[0] = c1;
    this.colors[1] = c2;
    this.colors[2] = c3;
    rClr[0] = c1;
    rClr[1] = c2;
    rClr[2] = c3;
  }
  Face getCopy(){
    Face temp = new Face(x, y, z);
    temp.set(colors[0], colors[1], colors[2]);
    return temp;
  }
}
