public class Sine extends Eq{
  float phase;
  float fre;
  float sp;
  float[] phases;
  float amp;
  
  Sine(float amp, float phase, float sp, float fre, int total, boolean dir){
    this.amp = amp;
    this.dir = dir;
    this.phase = phase;
    this.fre = fre;
    this.sp = sp;
    phases = new float[total];
    float lm = (fre/sp);
    for (int i = 0; i < total; i++){
      phases[i] = ((this.dir ? -1 : 1)*2*PI*lm*i + this.phase);
    }
  }
  
  float get(int i, float t){
    return this.amp*sin(2*PI*fre*t + this.phases[i]);
  }
  
}
