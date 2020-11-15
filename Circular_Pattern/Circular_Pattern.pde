import java.util.*;
import javafx.util.Pair;


float a1, a2;
float v1, v2;
float r1, r2;

HashSet<Pair<Float, Float>> set;

void setup(){
  size(800, 800);
  
  a1 = 0;
  a2 = 0;
  
  r1 = 80;
  r2 = 300;
  
  set = new HashSet<Pair<Float, Float>>();
  
  frameRate(30); 
  
  background(10);
  
}

void draw(){
  
  translate(width/2, height/2);
  scale(1, -1);
  
  noFill();
  stroke(245, 245, 245);
  circle(0, 0, 2*r1);
  circle(0, 0, 2*r2);
  
  set.add(new Pair(a1,a2));
  
  for (Pair<Float, Float> p: set){
    makeLine(p.getKey(), p.getValue());
  }
  
  update();
  
}

void makeLine(float aa1, float aa2){
  line(r1*cos(aa1*PI/180), r1*sin(aa1*PI/180), r2*cos(aa2*PI/180), r2*sin(aa2*PI/180));
}

void update(){
  a1 = (a1+12)%360;
  a2 = (a2+2)%360;
}
