ArrayList<Curve> l;
boolean touchStarted = false;
float tx, ty;
boolean added = false;

void setup(){
  size(960, 540);
  l = new ArrayList<Curve>();
}

void draw(){
  background(255);
  drawAxis();
  
  for (int i = 0; i < l.size(); i++){
    l.get(i).show();
  }
  
  for (int i = 0; i < l.size(); i++){
    for (int j = i+1; j < l.size(); j++){
      l.get(i).intersection(l.get(j));
    }
  }
  
}

void drawAxis(){
  translate(width/2, height/2);
  scale(1, -1);
  stroke(0);
  line(-width/2, 0, width/2, 0);
  line(0, -height/2, 0, height/2);
}

void mousePressed(){
  mouseX -= width/2;
  mouseY -= height/2;
  mouseY = -mouseY;
  touchStarted = true;
  tx = mouseX;
  ty = mouseY;
}

void mouseMoved(){
  mouseX -= width/2;
  mouseY -= height/2;
  mouseY = -mouseY;
  if (!touchStarted) {
    for (int i = 0; i < l.size(); i++){
      l.get(i).active = false;
    }
    for (int i = 0; i < l.size(); i++){
      if (l.get(i).check(mouseX, mouseY)){
        l.get(i).active = true;
        return;
      }
    }
    return;
  }
  if (!added) {
    l.add(new Line(tx, ty, mouseX, mouseY));
    added = true;
  }else{
    l.get(l.size()-1).x2 = mouseX;
    l.get(l.size()-1).y2 = mouseY;
  }
}

void mouseDragged(){
  mouseX -= width/2;
  mouseY -= height/2;
  mouseY = -mouseY;
  if (!added) {
    l.add(new Line(tx, ty, mouseX, mouseY));
    added = true;
  }else{
    l.get(l.size()-1).x2 = mouseX;
    l.get(l.size()-1).y2 = mouseY;
  }
}

void mouseReleased(){
  touchStarted = false;
  added = false;
  if (l.size()>0) l.get(l.size()-1).active = false;
}
