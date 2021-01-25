public class State{
  Face[] faces;
  State preState;
  char move;
  int codeIsDa;
  public State(Face[] ff, char preMove, State preState){
    faces = new Face[ff.length];
    for (int i = 0; i < ff.length; i++){
      faces[i] = ff[i].getCopy();
    }
    this.move = preMove;
    this.preState = preState;
    codeIsDa = temp();
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
    return codeIsDa;
  }
  private int temp(){
    StringBuilder res = new StringBuilder();
    for (int i = 0; i < 8; i++){
      int pos = 0;
      boolean found = false;
      for (int x = -1; x <= 1; x += 2){
        for (int y = -1; y <= 1; y += 2){
          for (int z = -1; z <= 1; z += 2){
            if (faces[i].x == x && faces[i].y == y && faces[i].z == z){
              found = true;
              break;
            }
            pos++;
          }
          if (found) break;
        }
        if (found) break;
      }
      if (correct == null){
        pos = 0;
      }else{
        if (correct.faces[i].colors[0] == faces[i].colors[1]){
          pos += 8;
        }else if (correct.faces[i].colors[0] == faces[i].colors[2]){
          pos += 16;
        }
      }
      if (pos < 10){
        res.append("0"+pos);
      }else{
        res.append(pos+"");
      }
    }
    //System.out.println(res);
    return res.hashCode();
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
