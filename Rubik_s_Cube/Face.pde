class Face{
  public int x, y, z;
  private int rx, ry, rz;
  private color[] rColors;
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
    drawSticker(this.x*(3-this.z), this.y, this.colors[0]);
    drawSticker(this.x, this.y*(3-this.z), this.colors[1]);
    drawSticker(this.x, (1-this.z)*3+this.y*this.z, this.colors[2]);
  }
  void set(color c1, color c2, color c3){
    this.colors[0] = c1;
    this.colors[1] = c2;
    this.colors[2] = c3;
    this.rColors = new color[]{c1, c2, c3};
  }
}
