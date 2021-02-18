class Point{
  Node data;
  Point parent;
  int n;
  int pow;
  Point(Node dataa){
    parent = this;
    data = dataa;
    n = 1;
    pow = 0;
  }
  Point getBoss(){
    Point temp = this;
    while (temp != temp.parent) temp = temp.parent;
    return temp;
  }
}
