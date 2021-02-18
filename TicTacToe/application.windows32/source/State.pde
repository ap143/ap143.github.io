public class State{
  MARK[][] data;
  State prev;
  public State(MARK[][] mr, State pre){
    data = mr;
    prev = pre;
  }
  State getNext(MARK nxt, int ii, int jj){
    MARK[][] temp = new MARK[3][3];
    for (int i = 0; i < 3; i++) for (int j = 0; j < 3; j++) temp[i][j] = data[i][j];
    temp[ii][jj] = nxt;
    return new State(temp, this);
  }
  @Override
  public int hashCode(){return 0;}
  @Override
  public boolean equals(Object a){
    if (a instanceof State){
      State st = (State) a;
      for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
          if (data[i][j] != st.data[i][j]) return false;
        }
      }
      return true;
    }
    return false;
  }
}
