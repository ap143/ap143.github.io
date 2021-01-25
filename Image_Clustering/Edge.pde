class Edge implements Comparable<Edge>{
  int weight;
  Node node1, node2;
  Edge(Node n1, Node n2, int w){
    node1 = n1;
    node2 = n2;
    weight = w;
  }
  void claim(){
    node1.addV(node2);
    node2.addV(node1);
  }
  int compareTo(Edge e){
    return this.weight - e.weight;
  }
}
