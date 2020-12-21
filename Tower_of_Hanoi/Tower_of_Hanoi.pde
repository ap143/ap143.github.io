import java.util.Stack;
import java.util.Iterator;
import java.util.Queue;
import java.util.LinkedList;

int n;
int len;
int wid;
ArrayList<Stack<Integer>> st;
Queue<int[]> qu;
Thread solve;

void setup(){
  size(1000, 800);
  n = 10;
  wid = 10;
  len = (height*2/3)/n;
  st = new ArrayList<Stack<Integer>>();
  for (int i = 0; i < 3; i++) st.add(new Stack<Integer>());
  for (int i = n; i >= 1; i--){
    st.get(0).push(i);
  }
  qu = new LinkedList<int[]>();
  slv(n, 0, 2, 1);
}

void draw(){
  background(200);
  translate(0, height);
  scale(1, -1);
  fill(50);
  stroke(50);
  rect(width/4, 0, 10, 2*height/3);
  rect(width/2, 0, 10, 2*height/3);
  rect(3*width/4, 0, 10, 2*height/3);
  Iterator<Integer> it = st.get(0).iterator();
  int j = 0;
  stroke(0, 0, 255);
  fill(255, 255, 0);
  strokeWeight(3);
  while(it.hasNext()){
    int i = it.next();
    rect(width/4+5-i/2.0*wid, j*len, i*wid, len); 
    j++;
  }
  it = st.get(1).iterator();
  j = 0;
  while(it.hasNext()){
    int i = it.next();
    rect(width/2+5-i/2.0*wid, j*len, i*wid, len); 
    j++;
  }
  it = st.get(2).iterator();
  j = 0;
  while(it.hasNext()){
    int i = it.next();
    rect(3*width/4+5-i/2.0*wid, j*len, i*wid, len); 
    j++;
  }
  update();
}

void update(){
  int[] cur = qu.remove();
  st.get(cur[1]).push(st.get(cur[0]).pop());
}

void tr(int a, int b){
  qu.add(new int[]{a, b});
}

void slv(int k, int a, int b, int c){
  if (k==0){
    return;
  }
  if (k == 1){
    tr(a, b);
    return;
  }
  slv(k-1, a, c, b);
  tr(a, b);
  slv(k-1, c, b, a);
}
