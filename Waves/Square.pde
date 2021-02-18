public class Square extends Eq{
   
  float phase;
  float fre;
  float sp;
  float[] phases;
  float amp;
  
  Square(float amp, float phase, float sp, float fre, int total, boolean dir){
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
    return sin(2*PI*fre*t + this.phases[i]) > 0 ? this.amp : 0;
  }
  
}
