class Box{
  PVector pos;
  float r;
  
  Box(float x, float y, float z, float r_){
    pos = new PVector(x, y, z);
    r = r_;
  }
  
  void draw(ArrayList<Box> list){
    noStroke();
    fill(255, 0, 0);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(r);
    popMatrix();
    if (rad <= 9) return; 
    if(!active) return;
    for(int x = -1; x <= 1; x++){
      for(int y = -1; y <= 1; y++){
        for(int z = -1; z <= 1; z++){
          int count = 0;
          count += x == 0 ? 1 : 0;
          count += y == 0 ? 1 : 0;
          count += z == 0 ? 1 : 0;
          if(count >= 2) continue;
          list.add(new Box(pos.x + x * r / 3, 
                           pos.y + y * r / 3, 
                           pos.z + z * r / 3, 
                           r / 3));
        }
      }
    }
  }
  
}
