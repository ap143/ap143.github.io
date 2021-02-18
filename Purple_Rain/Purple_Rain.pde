Drop[] d = new Drop[250];

void setup(){
  for (int i = 0; i < 250; i++){
    d[i] = new Drop();
  }
  size(1000, 1000);
}

void draw(){
  background(240, 200, 232);
  for (int i = 0; i < 250; i++){
    d[i].show();
    d[i].drop();
  }
}
