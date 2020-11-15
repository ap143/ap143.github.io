class Node {
  
  int data;
  Node parent, left, right;
  int h;
  
  public Node(int data){
    this.data = data;
    this.h = 1;
  }
  
  void show(float x, float y, float r){
    stroke(0);
    fill(255);
    circle(x, y, 2*r);
    fill(0);
    textAlign(CENTER, CENTER);
    text(this.data, x, y);
  }
  
}
