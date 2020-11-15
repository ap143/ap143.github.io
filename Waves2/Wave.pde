class Wave{  
  
  double[] nds;
  double[] xs;
  ArrayList<Eq> pls;
  private final float rsl;
  float t;
  float sp;
  
  public Wave(float sp){
    this.rsl = 1;
    this.sp = sp;
    nds = new double[int(width/rsl)+1];
    xs = new double[int(width/rsl)+1];
    pls = new ArrayList<Eq>();
    for (int i = 0; i < nds.length; i++) nds[i] = 0;
    for (int i = 0; i < nds.length; i++) xs[i] = i*rsl;
  }
  
  public void show(){
    stroke(255, 0, 0);
    strokeWeight(2);
    for (int i = nds.length - 2; i >= 0; i--){
      line((float) xs[i+1], (float) nds[i+1], (float) xs[i], (float) nds[i]); 
    }
    fill(0, 0, 255);
    circle(0, (float) nds[0], 15);
  }
  
  public void update(){
    for (int i = nds.length-1; i >= 1; i--){
      nds[i] = nds[i-1];
    }
    nds[0] = 0;
    for (int j = 0; j < pls.size(); j++){
      nds[0] += pls.get(j).getP(t);
    }
    t += 0.001;
  }
  
  public void addSine(float amp, float fre, float curPh){
    this.pls.add(new Sine(amp, fre, curPh));
  }
  
  void run(){
     for (int i = 0; i < this.sp; i++){
       translate(0, height/2);
        background(220);
        scale(1, -1);
        drawBaseLine();
       this.show();
       this.update();
     }
  }
  
}
