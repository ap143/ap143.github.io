ArrayList<Node> nodes;

void setup(){
  size(800, 800);
  
  nodes = new ArrayList();
  
  nodes.add(new Node());
  
  frameRate(60);
  
}

void draw(){
  
  background(50);
  
  for (int i = 0; i < nodes.size(); i++){
    nodes.get(i).show();
  }
  
  update(1);
  
}

void update(int n){
  if (n>=100) return;
  Node next = new Node();
  float tr = Float.MAX_VALUE;
  for (int i = 0; i < nodes.size(); i++){
    tr = min(dist(next.x, next.y, nodes.get(i).x, nodes.get(i).y)-nodes.get(i).r, tr);
  }
  if (tr<=10){
    update(n+1);
    return;
  }
  next.r = tr;
  if (next.x<next.r || 
      next.x>width-next.r ||
      next.y<next.r ||
      next.y>height-next.r){
    update(n+1);
    return;
  }
  
  tr = random(10, min(tr, 50));
  next.r = tr;
  nodes.add(next);
}

void keyPressed(){
  if(keyCode==ENTER){
    nodes.clear();
    nodes.add(new Node());
  }
}
