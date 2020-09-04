Spring spring;
Block block;
float t;
float A;
float springLength;
float blockY;
float blockSize;
float m;
float k;
float ph;
float graphSpeed;
boolean touchStarted = false;
ArrayList<Node> nodes;

void setup(){
  size(800, 800);
  t = 0;
  A = 100;
  m = 1;
  k = 100;
  ph = PI/2;
  springLength = width/2;
  blockY = height*(0.9);
  blockSize = 50;
  graphSpeed = 1;
  frameRate(100);
  spring = new Spring(0, blockY, springLength+A);
  block = new Block(springLength+100, blockY, blockSize);
  nodes = new ArrayList<Node>();
}

void draw(){
  background(200);
  block.show();
  spring.show();
  drawGraph();
  nodes.add(new Node(block.x, blockY, -graphSpeed));
  t += 0.01;
  if (!touchStarted) update();
}

void update(){
  block.x = springLength + (float) (exp(-t/10)*A*Math.sin(Math.sqrt(k/m)*t)+ph);
  spring.len = block.x;
}

void drawGraph(){
  line(width/2, blockY, width/2, 0);
  int i = 0;
  fill(20);
  noFill();
  beginShape();
  while (i < nodes.size()){
    if (nodes.get(i).y<=0){
      nodes.remove(i);
    }else{
      curveVertex(nodes.get(i).x, nodes.get(i).y);
      nodes.get(i).show();
      i++;
    }
  }
  endShape();
  fill(50);
  text(t + " s", width*(0.9), blockY);
}

void mousePressed(){
  if (key==0){
    if (abs(block.x-mouseX)<blockSize && abs(block.y-mouseY)<blockSize){
      touchStarted = true;
    }
  }
}

void mouseDragged(){
  if (touchStarted){
    block.x = constrain(mouseX, width/20, width*(0.95));
    A = block.x-width/2;
    spring.len = block.x;
    t = 0;
  }
}

void mouseReleased(){
  touchStarted = false;
}
