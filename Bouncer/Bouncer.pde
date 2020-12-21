import java.util.Queue;
import java.util.LinkedList;
import java.util.Iterator;

final float g = 9.81;
final float dt = 0.04;

Queue<Ball> balls = new LinkedList<Ball>();
Queue<Ball> tempQueue;
Iterator<Ball> it;

void setup(){
  size(1000, 800);
  balls.add(new Ball(width/2, height/8, 10, color(200, 0, 0)));
}

void draw(){
  background(255);
  it = balls.iterator();
  while (it.hasNext()){
    it.next().show();
  }
  update();
}

void update(){
  tempQueue = new LinkedList<Ball>(); 
  while (balls.size()>0){
    balls.remove().update();
  }
  balls = tempQueue;
}

void collide(Ball ball){
  if (ball.r <= 2 || ball.count >= 4){
    tempQueue.add(ball);
    return;
  }
  ball.count++;
  int n = 4;
  Ball[] res = new Ball[n];
  float rr, xx, yy;
  rr = xx = yy = 0;
  for (int i = 0; i < n-1; i++){
    res[i] = new Ball(ball.x, ball.y, ball.r, color(200, 0, 0));
    rr += res[i].r;
    xx += (res[i].vx = ball.vx + random(-2, 2));
    yy += (res[i].vy = ball.vy + random(-2, 2));
  }
  res[n-1] = new Ball(ball.x, ball.y, ball.r, color(200, 0, 0));
  res[n-1].vx = (n*ball.vx - xx);
  res[n-1].vy = (n*ball.vy - yy);
  for (Ball b: res){
    b.count = ball.count;
    tempQueue.add(b);
  }
}
