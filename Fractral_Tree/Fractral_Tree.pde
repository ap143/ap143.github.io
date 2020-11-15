ArrayList<Node> list = new ArrayList();
ArrayList<Node> l2 = new ArrayList();
boolean f = false;

void setup(){
  size(1600, 1000);
  list.add(new Node());
  background(0);
}

void draw(){
  if (f) return;
  l2.clear();
  for (int i = 0; i < list.size(); i++){
    list.get(i).show();
    if (list.get(i).cur>list.get(i).len){
      l2.add(list.get(i).copy1());
      l2.add(list.get(i).copy2());
      l2.add(list.get(i).copy3());
      l2.add(list.get(i).copy4());
    }else{
      l2.add(list.get(i).next());
    }
  }
  list.clear();
  list = (ArrayList<Node>) l2.clone();
  for (int i = 0; i < list.size(); i++){
    if (list.get(i).len<=20) f = true;
    break;
  }
}

void keyPressed(){
  if (keyCode==ENTER){
    clear();
    list.clear();
    list.add(new Node());
  }
}
