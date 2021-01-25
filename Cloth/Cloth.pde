import peasy.*;
import java.io.*;

int n = 25;
double r = 0.5;
PeasyCam cam;
Node[][] nodes;
double k = 10000;
double g = -1;
double c = 0.1;
double dt = 0.0001;
double rad = 2;
Node ball = new Node(0, 0, 25);
double e = 0.1;
double mass = 1000;
FileWriter data;
int time = 1000000;
BufferedReader read;

void setup(){
  size(900, 900, P3D);
  cam = new PeasyCam(this, 100);
  cam.rotateX(PI/2);
  nodes = new Node[n][n];
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      nodes[i][j] = new Node(i*2*r-r*n, j*2*r-r*n, 0);
    }
  }
  /*try{
    data = new FileWriter(new File("data.txt"));
  }catch (Exception e){
    return;
  }
  while(time>0){
    System.out.println(time);
    update();
    time--;
  }
  try{
    data.close();
  }catch(Exception e){}*/
  try{
    read = new BufferedReader(new FileReader(new File("data.txt")));
  }catch(Exception e){}
  System.out.println("F");
}

void draw(){
  for (int x = 0; x < 1; x++){
  background(200);
  lights();  
  stroke(0);
  noFill();
  /*try{
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      nodes[i][j].x = Double.parseDouble(read.readLine());
      nodes[i][j].y = Double.parseDouble(read.readLine());
      nodes[i][j].z = Double.parseDouble(read.readLine());
    }
  }
  ball.x = Double.parseDouble(read.readLine());
  ball.y = Double.parseDouble(read.readLine());
  ball.z = Double.parseDouble(read.readLine());
  }catch(Exception e) {}*/
  /*for (int i = 0; i < n-1; i += 1){
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < n; j += 1){
      vertex((float) nodes[i][j].x, (float) nodes[i][j].y, -(float) nodes[i][j].z);
      vertex((float) nodes[i+1][j].x, (float) nodes[i+1][j].y, -(float) nodes[i+1][j].z);
    }
    endShape();
  }*/
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      point((float) nodes[i][j].x, (float) nodes[i][j].y, (float) -nodes[i][j].z);
    }
  }
  noStroke();
  fill(0);
  pushMatrix();
  translate((float) ball.x, (float) ball.y, -(float) ball.z);
  fill(255);
  sphere((float) rad);
  popMatrix();
  for (int i = 0; i < 100; i++) update();
  }
}

boolean valid(int x, int y){
  if (x < 0 || x >= n || y < 0 || y >= n) return false;
  return true;
}

void update(){
  ball.fx = ball.fy = ball.fz = 0;
  double dtvx = 0;
  double dtvy = 0;
  double dtvz = 0;
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      if (j == 0) continue;
      if (j == n-1) continue;
      if (i == 0) continue;
      if (i == n-1) continue;
      double fx = 0;
      double fy = 0;
      double fz = 0;
      for (int x = -1; x <= 1; x++){
        for (int y = -1; y <= 1; y++){
          if (!valid(i+x, j+y)) continue;
          if (x == 0 && y == 0) continue;
          double len = dist((float) nodes[i][j].x, (float) nodes[i][j].y, (float) nodes[i][j].z,
                            (float) nodes[i+x][j+y].x, (float) nodes[i+x][j+y].y, (float) nodes[i+x][j+y].z);
          double kx;
          if (x*y == 0)
            kx = (len-2*r)*k;
          else
            kx = (len-2*sqrt(2)*r)*k/sqrt(2);
          fx += kx*(nodes[i+x][j+y].x-nodes[i][j].x);
          fy += kx*(nodes[i+x][j+y].y-nodes[i][j].y);
          fz += kx*(nodes[i+x][j+y].z-nodes[i][j].z);
        }
      }
      nodes[i][j].fx = fx-nodes[i][j].vx*c;
      nodes[i][j].fy = fy-nodes[i][j].vy*c;
      nodes[i][j].fz = fz-nodes[i][j].vz*c;
      
      PVector pos = new PVector((float) (ball.x - nodes[i][j].x), (float) (ball.y - nodes[i][j].y), (float) (ball.z - nodes[i][j].z));
      if (pos.mag() > rad) continue;
      //if (pos.mag()-rad < 0.1) System.out.println("F");
      PVector ballV = new PVector((float) ball.vx, (float) ball.vy, (float) ball.vz);
      PVector nodeV = new PVector((float) nodes[i][j].vx, (float) nodes[i][j].vy, (float) nodes[i][j].vz);
      double v1 = ballV.dot(pos)/pos.mag();
      double v2 = nodeV.dot(pos)/pos.mag();
      if (v1 >= v2) continue;
      double dV = (v2*(1+e)+v1*(mass-e))/(mass+1)-v1;
      dtvx += dV*pos.x/pos.mag();
      dtvy += dV*pos.y/pos.mag();
      dtvz += dV*pos.z/pos.mag();
      dV = (v2*(1-mass*e)+v1*mass*(1+e))/(1+mass)-v2;
      nodes[i][j].fx += dV*pos.x/pos.mag()/dt - nodes[i][j].fx*pos.x/pos.mag();
      nodes[i][j].fy += dV*pos.y/pos.mag()/dt - nodes[i][j].fy*pos.y/pos.mag();
      nodes[i][j].fz += dV*pos.z/pos.mag()/dt - nodes[i][j].fz*pos.z/pos.mag();
    }
  }
  ball.fz += g;
  ball.vx += ball.fx*dt + dtvx;
  ball.vy += ball.fy*dt + dtvy;
  ball.vz += ball.fz*dt + dtvz;
  ball.x += ball.vx*dt;
  ball.y += ball.vy*dt;
  ball.z += ball.vz*dt;
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      nodes[i][j].vx += nodes[i][j].fx*dt;
      nodes[i][j].vy += nodes[i][j].fy*dt;
      nodes[i][j].vz += nodes[i][j].fz*dt;
      nodes[i][j].x += nodes[i][j].vx*dt;
      nodes[i][j].y += nodes[i][j].vy*dt;
      nodes[i][j].z += nodes[i][j].vz*dt;
    }
  }
  if (time % 1000 != 0) return;
  try{
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
      data.write(String.valueOf(nodes[i][j].x)+"\n");
      data.write(String.valueOf(nodes[i][j].y)+"\n");
      data.write(String.valueOf(nodes[i][j].z)+"\n");
    }
  }
  data.write(String.valueOf(ball.x)+"\n");
  data.write(String.valueOf(ball.y)+"\n");
  data.write(String.valueOf(ball.z)+"\n");
  }catch(Exception e){}
}
