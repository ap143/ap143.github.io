import peasy.*;
import java.util.LinkedList;

color[] colors = {color(255, 255, 0), color(0, 255, 0), 
                  color(0, 64, 255), color(255, 0, 255),
                  color(255, 255, 255)};

PVector[] paths;

float dt = 0.002;
float sigma = 10, beta = 2.67, rho = 28;

LinkedList<PVector>[] list;

PeasyCam cam;

void setup(){
  fullScreen(P3D);
  
  cam = new PeasyCam(this, 200);
  
  paths = new PVector[5];
  list = new LinkedList[paths.length];
  
  for(int i = 0; i < paths.length; i++){
    paths[i] = new PVector(random(-40, 40), 
                           random(-40, 40),
                           random(-40, 40));
    list[i] = new LinkedList<PVector>();
  }
 
}

void draw(){
  
  background(0);
  
  // translate(width / 2, height / 2);
  // scale(2);
  
  for(int r = 0; r < 2; r++){
  for(int i = 0; i < paths.length; i++){
    float dx = sigma*(paths[i].y-paths[i].x)*dt;
    float dy = (paths[i].x*(rho-paths[i].z)-paths[i].y)*dt;
    float dz = (paths[i].x*paths[i].y-beta*paths[i].z)*dt;
    paths[i].x += dx;
    paths[i].y += dy;
    paths[i].z += dz;
    list[i].add(new PVector(paths[i].x, paths[i].y, paths[i].z));
  }
  }
  noFill();
  strokeWeight(2);
  
  for(int i = 0; i < paths.length; i++){
    stroke(colors[i%5]);
    beginShape();
    for (PVector p: list[i]){
      vertex(p.x, p.y, p.z);
    }
    endShape();
  }
  cam.rotateY(0.01);
  
}
