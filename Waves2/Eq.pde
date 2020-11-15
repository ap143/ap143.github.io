public abstract class Eq {
  protected abstract double getP(float t);
}

class Sine extends Eq {
  
  float curPh;
  float fre;
  float sp;
  float amp;
  
  Sine(float amp, float fre, float curPh){
    this.amp = amp;
    this.fre = fre;
    this.curPh = curPh;
  }
  
  double getP(float t){
    return this.amp*Math.sin(2*PI*this.fre*t + this.curPh); 
  }

}
