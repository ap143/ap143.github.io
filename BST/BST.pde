
Node root;
float len;
float rad;
AVL tr;
boolean f = true;

void setup(){
  
  surface.setResizable(true);
  surface.setSize(int(displayWidth*0.95), int(displayHeight*0.95));
  surface.setLocation(0, 0);
  
  len = width*0.9/2;
  rad = width/400;
  
  tr = new AVL<Integer>();
  
  frameRate(60);
  
  draw();

}

void draw(){
  //for (int i = 0; i < 10; i++){
  background(200);
  translate(width/2, height/15);
  
  textAlign(CENTER, CENTER);
  
  textSize(rad);
  fill(0);
  text("Total number of elements = " + tr.total, 0, -height/20);
  
  strokeWeight(2);
  
  if (getH(tr.root) >= 20) return;
  
  drawNodes();
  
  if (f) initial();
  //}
}

void initial(){
  f = true;
  tr.insert(int(random(1, tr.total*10+100)));
  updateHeight(tr.root, 1);
}

void insert(int data){
  if (root == null) {
    root = new Node(data);
    return;
  }
  Node trav = root;
  while (true){
    if (data == trav.data) return;
    if (data > trav.data){
      if (trav.right == null){
        trav.right = new Node(data);
        trav.right.parent = trav;
        trav = trav.right;
        break;
      }else{
        trav = trav.right;
      }
    }else{
      if (trav.left == null){
        trav.left = new Node(data);
        trav.left.parent = trav;
        trav = trav.left;
        break;
      }else{
        trav = trav.left;
      }
    }
  }
  //updateHeight(root, 1);
}

void updateHeight(TreeNode node, int h){
  if (node == null) return;
  node.hh = h;
  updateHeight(node.left, h+1);
  updateHeight(node.right, h+1);
}

int getH(TreeNode node){
  if (node == null) return 0;
  else return node.h;
}

void check(TreeNode node){
  if (node == null) return;
  int h1 = getH(node.left);
  int h2 = getH(node.right);
  if (abs(h1 - h2) > 1) System.out.println(node.data);
  check(node.left);
  check(node.right);
}

void drawNodes(){
  //check(tr.root);
  drawLines(tr.root, 0, 0, 0, 0);
  drawNodes(tr.root, 0, 0, 0, 0);
}

void drawLines(TreeNode node, float x1, float y1, float x2, float y2){
  if (node == null) return;
  line(x1, y1, x2, y2);
  float pos = len/(pow(2, node.hh)-1)/2;
  drawLines(node.left, x1 - pos, y1 + 50, x1, y1);
  drawLines(node.right, x1 + pos, y1 + 50, x1, y1);
}

void drawNodes(TreeNode node, float x1, float y1, float x2, float y2){
  if (node == null) return;
  textSize(3*rad/4);
  node.show(x1, y1, rad);
  float pos = len/(pow(2, node.hh)-1)/2;
  drawNodes(node.left, x1 - pos, y1 + 50, x1, y1);
  drawNodes(node.right, x1 + pos, y1 + 50, x1, y1);
}

void mouseClicked(){
  f = true;
}
