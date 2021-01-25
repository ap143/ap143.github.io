import java.util.Scanner;

ArrayList<double[]> data = new ArrayList<double[]>();
int m;
double xmin, xmax, ymin, ymax;
double t1 = 0, t0 = 800;
double learningRate = 0.000001;

void setup(){
  size(900, 900);
  try{
    Scanner read = new Scanner(new File(
      "D:\\Github\\PublicCodes\\Linear_Regression\\train.csv"));
    read.next();
    xmin = Double.MAX_VALUE;
    xmax = Double.MIN_VALUE;
    ymin = xmin;
    ymax = xmax;
    while (read.hasNext()){
      String[] temp = read.next().split(",");
      xmin = Math.min(xmin, Double.parseDouble(temp[0]));
      ymin = Math.min(ymin, Double.parseDouble(temp[1]));
      xmax = Math.max(xmax, Double.parseDouble(temp[0]));
      ymax = Math.max(ymax, Double.parseDouble(temp[1]));
      data.add(new double[]{Double.parseDouble(temp[0]), 
                            Double.parseDouble(temp[1])});
    }
    read.close();
  }catch (Exception e){
    e.printStackTrace();
  }
  data.clear();
  for(int i = 0; i < 800; i++){
    data.add(new double[]{10*noise(i)+i, 10*noise(800-i)+800-i});
  }
  xmin = 0;
  xmax = 800;
  ymin = 0;
  ymax = 800;
  m = data.size();
  System.out.println(m);
  // frameRate(20);
}

void draw(){
  background(255);
  translate(50, 850);
  scale(1, -1);
  drawAxes();
  plot();
  drawLine();
  update();
  //System.out.println(t0+" "+t1);
}

void update(){
  double temp0 = t0 - learningRate*pd_t0();
  double temp1 = t1 - learningRate*pd_t1();
  t0 = temp0;
  t1 = temp1;
}

double pd_t0(){
  double res = 0;
  for(int i = 0; i < m; i++){
    double x = data.get(i)[0];
    double y = data.get(i)[1];
    res += t0+t1*x-y;
  }
  return res / m;
}

double pd_t1(){
  double res = 0;
  for(int i = 0; i < m; i++){
    double x = data.get(i)[0];
    double y = data.get(i)[1];
    res += x*(t0+t1*x-y);
  }
  return res / m;
}

void drawLine(){
  stroke(255, 0, 0);
  strokeWeight(3);
  line(0, myMap(t0, false), 
        800, myMap(t0+xmax*t1, false));
}

float myMap(double a, boolean f){
  if (f) return map((float) a, (float) xmin, (float) xmax,
                                0, 800);
  else return map((float) a, (float) ymin, (float) ymax,
                                0, 800);
}

void plot(){
  stroke(0, 0, 255);
  for(int i = 0; i < m; i++){
    float x = myMap(data.get(i)[0], true);
    float y = myMap(data.get(i)[1], false);
    point(x, y);
  }
}

void drawAxes(){
  stroke(0);
  strokeWeight(3);
  line(0, 0, 800, 0);
  line(0, 0, 0, 800);
  line(0, 800, -10, 790);
  line(0, 800, 10, 790);
  line(800, 0, 790, 10);
  line(800, 0, 790, -10);
}
