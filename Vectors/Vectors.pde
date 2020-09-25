float scl;
ArrayList<Vector> l;
float px, py;
boolean added = false;

void setup(){
  size(800, 800);
  
  scl = 10;
  l = new ArrayList<Vector>();
  l.add(new Vector(10, 1));
}

void draw(){
  background(240);
  
  transform();
  drawAxes();
  
  for (int i = 0; i < l.size(); i++){
    l.get(i).show();
  }
  
}

void transform(){
  translate(width/2, height/2);
  scale(1, -1);
  surface.setResizable(true);
}

void drawAxes(){
  line(-width/2, 0, width/2, 0);
  line(0, -height/2, 0, height/2);
  
  
  
}

void mouseWheel(MouseEvent e){
  scl += e.getCount()/2.0;
  if (scl<0.5) {
    scl = 0.5;
  }
}

void mousePressed(){
  px = mouseX;
  py = mouseY;
  added = false;
}

void mouseDragged(){
  
}
