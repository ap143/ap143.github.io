import processing.video.*;
import java.util.LinkedList;
import java.util.Stack;
import java.util.Collections;

int margin = 10;
PImage img, bg;
int n, m;
color[][] data;
int[][] lvls;
Node[][] nodes;
ArrayList<Edge> ar;
boolean[][] visited;
Capture cam;

void setup(){
  img = loadImage("tree.jpg");
  bg = loadImage("tree.jpg");
  surface.setLocation(100, 10);
  surface.setSize(2*img.width, img.height);
  while (true){
    try{
      //cam = new Capture(this, width, height);
      break;
    }catch (Exception e){}
  }
  //cam.start();
  n = img.width;
  m = img.height;
  data = new color[m][n];
  nodes = new Node[m][n];
  lvls = new int[m][n];
  for (int i = 0; i < m; i++){
    for (int j = 0; j < n; j++){
      data[i][j] = color(img.get(j, i));
      nodes[i][j] = new Node(j, i);
    }
  }
  solve();
}

void draw(){
  image(img, 0, 0);
  image(bg, width/2, 0);
  //background(0);
  /*if (cam.available()) {
    cam.read();
    img = cam;
    n = img.width;
    m = img.height;
    /*data = new color[m][n];
    nodes = new Node[m][n];
    lvls = new int[m][n];
    for (int i = 0; i < m; i++){
      for (int j = 0; j < n; j++){
        data[i][j] = img.get(j, i);
        nodes[i][j] = new Node(j, i);
      }
    }
    solve();
    for (int i = 0; i < n; i++){
      for (int j = 0; j < m; j++){
        color c = img.get(i, j);
        img.set(i, j, color(red(c), (255-green(c))/2, blue(c)));
      }
    }
    image(img, 0, 0);
  }*/
}

void solve(){
  ar = new ArrayList<Edge>();
  for (int i = 0; i < n-1; i++){
    for (int j = 0; j < m; j++){
      ar.add(new Edge(nodes[j][i], nodes[j][i+1], diff(i, j, i+1, j)));
    }
  }
  for (int i = 0; i < m-1; i++){
    for (int j = 0; j < n; j++){
      ar.add(new Edge(nodes[i][j], nodes[i+1][j], diff(j, i, j, i+1)));
    }
  }
  Collections.sort(ar);
  System.out.println(n+" "+m+"="+ar.size());
  Point[][] set = new Point[m][n];
  for (int i = 0; i < n; i++){
    for (int j = 0; j < m; j++){
      set[j][i] = new Point(nodes[j][i]);
    }
  }
  for (Edge e: ar){
    if (e.weight > margin) continue;
    if (same(set[e.node1.y][e.node1.x], set[e.node2.y][e.node2.x], e.weight)) continue;
    e.claim();
    merge(set[e.node1.y][e.node1.x], set[e.node2.y][e.node2.x], e.weight);
  }
  visited = new boolean[m][n];
  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      visited[i][j] = false;
    }
  }
  ArrayList<Integer> levels = new ArrayList<Integer>();
  int cur = 0;
  for (int i = 0; i < m; i++){
    for (int j = 0; j < n; j++){
      if (visited[i][j]) continue;
      color clr = bfs(nodes[i][j], cur++);
      levels.add(clr);
      try{
        //Thread.sleep(2000);
      }catch(Exception e){
      }
    }
  }
  for (int i = 0; i < m; i++){
    for (int j = 0; j < n; j++){
      img.set(j, i, levels.get(lvls[i][j]));
    }
  }
}

color bfs(Node a, int c){
  float r = 0;
  float g = 0;
  float b = 0;
  int n = 0;
  visited[a.y][a.x] = true;
  Stack<Node> st = new Stack<Node>();
  st.add(a);
  while (st.size() != 0){
    Node res = st.pop();
    lvls[res.y][res.x] = c;
    color temp = img.get(res.x, res.y);
    r += red(temp);
    g += green(temp);
    b += blue(temp);
    n++;
    for (Node v: res.adj){
      if (visited[v.y][v.x]) continue;
      visited[v.y][v.x] = true;
      st.add(v);
    }
  }
  return color(r/n, g/n, b/n);
}

void merge(Point a, Point b, int w){
  if (a.n > b.n){
    b.getBoss().parent = a.getBoss();
    a.pow = (b.pow*b.n + a.pow*a.n + w)/(a.n + b.n);
    a.n += b.n;
  }else{
    a.getBoss().parent = b.getBoss();
    b.pow = (b.pow*b.n + a.pow*a.n + w)/(a.n + b.n);
    b.n += a.n;
  }
}

boolean same(Point a, Point b, int w){
  while (a != a.parent) a = a.parent;
  while (b != b.parent) b = b.parent;
  return a.data == b.data && (w - (a.pow+b.pow)/2.0 < margin);
}

int diff(int x1, int y1, int x2, int y2){
  return (int) dist(red(data[y1][x1]), green(data[y1][x1]), blue(data[y1][x1]), 
              red(data[y2][x2]), green(data[y2][x2]), blue(data[y2][x2]));
}
