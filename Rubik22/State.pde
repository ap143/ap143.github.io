public class State implements Comparable{
  Face[] faces;
  State preState;
  char move;
  public State(Face[] ff, char preMove, State preState){
    faces = new Face[ff.length];
    for (int i = 0; i < ff.length; i++){
      faces[i] = ff[i].getCopy();
    }
    this.move = preMove;
    this.preState = preState;
  }
  @Override
  public int compareTo(Object a){
    
    if (a instanceof State){
      if (equalStates(this, (State) a)) return 0;
      int c = 0;
      State ss = (State) a;
      for (int i = 0; i < 8; i++){
        if (equalS(faces[i], ss.faces[i])) c++;      
      }
      if (c >= 2) return 1;
      else return -1;
    }
    return -1;
  }
  @Override
  public boolean equals(Object a){
    if (a instanceof State){
      return equalStates(this, (State) a);
    }
    return false;
  }
  @Override
  public int hashCode(){
    return 0;
  }
  State getRotated(char a){
    Face[] temp = new Face[8];
    int cur = 0;
    if (a == 'R'){
      for (Face f: faces){
        if (f.x != 1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(1, 0, 0);
        temp[cur++] = f.getCopy();
        f.rotate(-1, 0, 0);
      }
    }else if (a == 'r'){
      for (Face f: faces){
        if (f.x != 1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(-1, 0, 0);
        temp[cur++] = f.getCopy();
        f.rotate(1, 0, 0);
      }
    }else if (a == 'L'){
      for (Face f: faces){
        if (f.x != -1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(-1, 0, 0);
        temp[cur++] = f.getCopy();
        f.rotate(1, 0, 0);
      }
    }else if (a == 'l'){
      for (Face f: faces){
        if (f.x != -1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(1, 0, 0);
        temp[cur++] = f.getCopy();
        f.rotate(-1, 0, 0);
      }
    }else if (a == 'U'){
      for (Face f: faces){
        if (f.y != 1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(0, 1, 0);
        temp[cur++] = f.getCopy();
        f.rotate(0, -1, 0);
      }
    }else if (a == 'u'){
      for (Face f: faces){
        if (f.y != 1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(0, -1, 0);
        temp[cur++] = f.getCopy();
        f.rotate(0, 1, 0);
      }
    }else if (a == 'D'){
      for (Face f: faces){
        if (f.y != -1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(0, -1, 0);
        temp[cur++] = f.getCopy();
        f.rotate(0, 1, 0);
      }
    }else if (a == 'd'){
      for (Face f: faces){
        if (f.y != -1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(0, 1, 0);
        temp[cur++] = f.getCopy();
        f.rotate(0, -1, 0);
      }
    }else if (a == 'F'){
      for (Face f: faces){
        if (f.z != 1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(0, 0, 1);
        temp[cur++] = f.getCopy();
        f.rotate(0, 0, -1);
      }
    }else if (a == 'f'){
      for (Face f: faces){
        if (f.z!= 1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(0, 0, -1);
        temp[cur++] = f.getCopy();
        f.rotate(0, 0, 1);
      }
    }else if (a == 'B'){
      for (Face f: faces){
        if (f.z != -1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(0, 0, -1);
        temp[cur++] = f.getCopy();
        f.rotate(0, 0, 1);
      }
    }else if (a == 'b'){
      for (Face f: faces){
        if (f.z != -1) {
          temp[cur++] = f.getCopy();
          continue;
        }
        f.rotate(0, 0, 1);
        temp[cur++] = f.getCopy();
        f.rotate(0, 0, -1);
      }
    }
    return new State(temp, a, this);
  }
}
