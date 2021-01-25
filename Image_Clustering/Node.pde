class Node{
  int x, y;
  LinkedList<Node> adj;
  Node(int xx, int yy){
    x = xx;
    y = yy;
    adj = new LinkedList<Node>();
  }
  void addV(Node node){
    adj.add(node);
  }
}
