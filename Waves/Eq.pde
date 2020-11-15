public abstract class Eq{
  
  boolean dir = true;
  abstract float get(int i, float t);
  
}

class SqDist extends Eq{
  
  float fre;
  float sp, amp;
  
  SqDist(float amp, float fre, float sp){
    this.fre = fre;
    this.amp = amp;
    this.sp = sp;
  }
  
  float get(int i, float t){
    return 0 <= i - t*sp && i - t*sp <= sp/fre ? amp : 0 ;
  }
  
}
