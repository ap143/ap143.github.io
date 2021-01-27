import peasy.*;

float rad;
PeasyCam cam;

boolean active = false;

ArrayList<Box> list = new ArrayList<Box>();

void setup(){
  size(960, 720, P3D);
  
  rad = pow(3, 6);
  
  cam = new PeasyCam(this, 1500);
  
  list.add(new Box(0, 0, 0, rad));
  
}

void draw(){
  System.out.println(list.size());
  background(0);
  float[] pos = cam.getPosition();
  pointLight(255, 255, 255, pos[0], pos[1], pos[2]);
  ArrayList<Box> temp = new ArrayList<Box>();
  for(Box b: list){
    b.draw(temp);
  }
  saveFrame("temp/save_#####.png");
  if (!active) return;
  list.clear();
  list = temp;
  active = false;
}

void mouseClicked(){
  active = true;
}
