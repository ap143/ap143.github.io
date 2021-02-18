Node[] nodes = new Node[200];

void setup(){
  size(1000, 800);
  for (int i = 0; i < nodes.length; i++){
    nodes[i] = new Node();
  }
}

void draw(){
  background(0);
  for (int i = 0; i < nodes.length; i++){
    nodes[i].show();
  }
}
