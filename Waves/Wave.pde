public class Wave{
  
  private int[][] colors = {{30, 132, 73},
                            {0, 0, 255},
                            {255, 255, 0},
                            {128, 0, 0},
                            {128, 128, 128},
                            {192, 57, 43},
                            {93, 109, 126}
                              };
  float[] nodes;
  float sp;
  ArrayList<Eq> pl;
  float rate = 1;
  boolean refl;
  
  Wave(boolean refl){
    this.nodes = new float[int(width/rate)];
    this.pl = new ArrayList<Eq>();
    this.refl = refl;
  }
  
  void show(){
    noFill();
    strokeWeight(3);
    stroke(255, 0, 0);
    for (int i = 1; i < nodes.length; i++){
      line((i-1)*rate, nodes[i-1], i*rate, nodes[i]);
    }
  }
  
  void drawInd(int i, float t){
    stroke(colors[i][0], colors[i][1], colors[i][2]);
    Eq tempW = pl.get(i);
    float pre = tempW.get(0, t);
    for (int j = 1; j < nodes.length; j++){
      line((j-1)*rate, pre, j*rate, pre = tempW.get(j, t));
    }
    fill(0);
    circle(0, nodes[0], 15);
  }
  
  void set(float sp){
    this.sp = sp;
  }
  
  void update(float t){
    for (int i = 0; i < nodes.length; i++){
      nodes[i] = 0;
      for (int j = 0; j < pl.size(); j++){
        nodes[i] += pl.get(j).get(i, t);
      }
    }
    noFill();
    strokeWeight(1.2);
    for (int i = 0; i < this.pl.size(); i++){
      drawInd(i, t);
    }
  }
  
  void addSine(float amp, float phase, float fre, boolean dir){
    pl.add(new Sine(amp, phase, this.sp, fre, this.nodes.length, dir));
  }
  
  void addSquare(float amp, float phase, float clock, boolean dir){
    pl.add(new Square(amp, phase, this.sp, clock, this.nodes.length, dir));
  }
  
  void addSquarePulse(float amp, float clock){
    pl.add(new SqDist(amp, clock, this.sp));
  }
  
}
