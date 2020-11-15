import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BST extends PApplet {


Node root;
float len;
float rad;
AVL tr;
boolean f = false;

public void setup(){
  
  surface.setResizable(true);
  surface.setSize(PApplet.parseInt(displayWidth*0.95f), PApplet.parseInt(displayHeight*0.95f));
  surface.setLocation(0, 0);
  
  len = width*0.9f/2;
  rad = width/100;
  
  tr = new AVL<Integer>();
  
  frameRate(60);
  
  draw();

}

public void draw(){
  //for (int i = 0; i < 10; i++){
  background(200);
  translate(width/2, height/15);
  
  textAlign(CENTER, CENTER);
  
  textSize(rad);
  fill(0);
  text("Total number of elements = " + tr.total, 0, -height/20);
  
  strokeWeight(2);
  
  if (getH(tr.root) >= 20) return;
  
  drawNodes();
  
  if (f) initial();
  //}
}

public void initial(){
  f = false;
  tr.insert(PApplet.parseInt(random(1, tr.total*10+100)));
  updateHeight(tr.root, 1);
}

public void insert(int data){
  if (root == null) {
    root = new Node(data);
    return;
  }
  Node trav = root;
  while (true){
    if (data == trav.data) return;
    if (data > trav.data){
      if (trav.right == null){
        trav.right = new Node(data);
        trav.right.parent = trav;
        trav = trav.right;
        break;
      }else{
        trav = trav.right;
      }
    }else{
      if (trav.left == null){
        trav.left = new Node(data);
        trav.left.parent = trav;
        trav = trav.left;
        break;
      }else{
        trav = trav.left;
      }
    }
  }
  //updateHeight(root, 1);
}

public void updateHeight(TreeNode node, int h){
  if (node == null) return;
  node.hh = h;
  updateHeight(node.left, h+1);
  updateHeight(node.right, h+1);
}

public int getH(TreeNode node){
  if (node == null) return 0;
  else return node.h;
}

public void check(TreeNode node){
  if (node == null) return;
  int h1 = getH(node.left);
  int h2 = getH(node.right);
  if (abs(h1 - h2) > 1) System.out.println(node.data);
  check(node.left);
  check(node.right);
}

public void drawNodes(){
  //check(tr.root);
  drawLines(tr.root, 0, 0, 0, 0);
  drawNodes(tr.root, 0, 0, 0, 0);
}

public void drawLines(TreeNode node, float x1, float y1, float x2, float y2){
  if (node == null) return;
  line(x1, y1, x2, y2);
  float pos = len/(pow(2, node.hh)-1)/2;
  drawLines(node.left, x1 - pos, y1 + 50, x1, y1);
  drawLines(node.right, x1 + pos, y1 + 50, x1, y1);
}

public void drawNodes(TreeNode node, float x1, float y1, float x2, float y2){
  if (node == null) return;
  textSize(3*rad/4);
  node.show(x1, y1, rad);
  float pos = len/(pow(2, node.hh)-1)/2;
  drawNodes(node.left, x1 - pos, y1 + 50, x1, y1);
  drawNodes(node.right, x1 + pos, y1 + 50, x1, y1);
}

public void mouseClicked(){
  f = true;
}


public class AVL<T extends Comparable<T>> extends BT<T> {

  @Override
  public TreeNode<T> insert(T data) {
    return this.reArrange(super.insert(data));
  }
  
  private TreeNode<T> reArrange(TreeNode<T> node){
    TreeNode<T> res = node;
    node = this.heightCheck(node);
    if (node == null) return res;
    TreeNode<T> z = node;
    TreeNode<T> y = this.getH(node.left) > this.getH(node.right) ? node.left : node.right;
    TreeNode<T> x = this.getH(y.left) > this.getH(y.right) ? y.left : y.right;
    TreeNode<T> pr = z.parent;
    if (z.left == y && y.left == x) {
      this.rotate(y, z, pr);
    }else if (z.right == y && y.right == x){
      this.rotate(z, y, pr);
    }else if (z.right == y && y.left == x) {
      this.rotate(x, y, z);
      this.rotate(z, x, pr);
    }else if (z.left == y && y.right == x) {
      this.rotate(y, x, z);
      this.rotate(x, z, pr);
    }
    this.heightCheck(res);
    return res;
  }
  
  private int getH(TreeNode<T> node) {
    return node == null ? 0 : node.h;
  }

  @Override
  public boolean delete(T data) {
    TreeNode<T> node = super.deleteN(data);
    if (node == null) return false;
    node = this.heightCheck(node);
    while (node != null) {
      TreeNode<T> z = node;
      TreeNode<T> y = this.getH(node.left) > this.getH(node.right) ? node.left : node.right;
      TreeNode<T> x = this.getH(y.left) > this.getH(y.right) ? y.left : y.right;
      TreeNode<T> pr = z.parent;
      if (z.left == y && y.left == x) {
        this.rotate(y, z, pr);
      }else if (z.right == y && y.right == x){
        this.rotate(z, y, pr);
      }else if (z.right == y && y.left == x) {
        this.rotate(x, y, z);
        this.rotate(z, x, pr);
      }else if (z.left == y && y.right == x) {
        this.rotate(y, x, z);
        this.rotate(x, z, pr);
      }
      node = this.heightCheck(pr);
    }
    return true;
  }
  
  private TreeNode<T> rotate(TreeNode<T> left, TreeNode<T> right, TreeNode<T> parent){
    if (left.parent == right) {
      right.setLeft(left.right);
      left.setRight(right);
      right.resetH();
      left.resetH();
      this.setChild(parent, right, left);
      return left;
    }else if(right.parent == left) {
      left.setRight(right.left);
      right.setLeft(left);
      right.resetH();
      left.resetH();
      this.setChild(parent, left, right);
      return right;
    }else {
      return null;
    }
  }

  private void setChild(TreeNode<T> parent, TreeNode<T> old, TreeNode<T> cur) {
    if (parent == null) {
      this.root = cur;
      cur.parent = null;
      return;
    }
    if (parent.left == old) parent.setLeft(cur);
    else parent.setRight(cur);
    parent.resetH();
  }

  private TreeNode<T> heightCheck(TreeNode<T> node){
    while (node != null) {
      int h1 = getH(node.left);
      int h2 = getH(node.right);
      if (Math.abs(h1 - h2) > 1) {
        break;
      }else {
        node.resetH();
      }
      node = node.parent;
    }
    return node;
  }
  
  @Override
  public boolean search(T data) {
    return super.search(data);
  }
  
}


public class BT<T extends Comparable<T>> {
  
  protected TreeNode<T> root;
  
  protected int total = 0;
  
  public TreeNode<T> insert(T data) {
    if (this.root == null) {
      this.root = new TreeNode<T>(data);
      this.total++;
      return this.root;
    }else {
      TreeNode<T> trav = this.root;
      TreeNode<T> node = new TreeNode<T>(data);
      while (true) {
        if (trav.compareTo(node) == 0) return trav;
        else if (trav.compareTo(node) > 0) {
          if (trav.left == null) {
            this.total++;
            return trav.setLeft(node);
          }
          else trav = trav.left;
        }else {
          if (trav.right == null) {
            this.total++;
            return trav.setRight(node);
          }
          else trav = trav.right;
        }
      }
    }
  }
  
  public boolean delete(T data) {
    TreeNode<T> node = this.get(data);
    if (node == null) return false;
    if (node.left != null && node.right != null) {
      TreeNode<T> trav = node.left;
      while (trav.right != null) trav = trav.right;
      node.data = trav.data;
      this.delete(trav);
    }else {
      this.delete(node);
    }
    return true;
  }
  
  protected TreeNode<T> deleteN(T data){
    TreeNode<T> node = this.get(data);
    if (node == null) return null;
    if (node.left != null && node.right != null) {
      TreeNode<T> trav = node.left;
      while (trav.right != null) trav = trav.right;
      node.data = trav.data;
      return this.delete(trav);
    }else {
      return this.delete(node);
    }
  }
  
  protected TreeNode<T> delete(TreeNode<T> node) {
    if (node.parent == null) {
      if (node.left == null && node.right == null) {
        this.root = null;
      }else {
        if (node.left != null) {
          this.root = node.left;
        }else {
          this.root = node.right;
        }
      }
      return this.root;
    }
    if (node.left == null && node.right == null) {
      if (node.parent.left == node) {
        node.parent.left = null;
      }else {
        node.parent.right = null;
      }
      return node.parent;
    }else {
      if (node.left != null) {
        if (node.parent.left == node) {
          node.parent.left = node.left;
          node.left.parent = node.parent;
        }else {
          node.parent.right = node.left;
          node.left.parent = node.parent;
        }
        return node.left;
      }else {
        if (node.parent.left == node) {
          node.parent.left = node.right;
          node.right.parent = node.parent;
        }else {
          node.parent.right = node.right;
          node.right.parent = node.parent;
        }
        return node.right;
      }
    }
  }
  
  protected TreeNode<T> get(T data){
    TreeNode<T> trav = this.root;
    while (trav != null) {
      if (trav.data.compareTo(data) == 0) return trav;
      else if (trav.data.compareTo(data) > 0) trav = trav.left;
      else trav = trav.right;
    }
    return trav;
  }
  
  public boolean search(T data) {
    return this.get(data) == null ? false : true;
  }
  
  protected void pre(TreeNode<? extends Comparable<?>> root) {
    if (root == null) return;
    System.out.print(root.data+" ");
    pre(root.left);
    pre(root.right);
  }
  
}
class Node {
  
  int data;
  Node parent, left, right;
  int h;
  
  public Node(int data){
    this.data = data;
    this.h = 1;
  }
  
  public void show(float x, float y, float r){
    stroke(0);
    fill(255);
    circle(x, y, 2*r);
    fill(0);
    textAlign(CENTER, CENTER);
    text(this.data, x, y);
  }
  
}


public class TreeNode<T extends Comparable<T>> implements Comparable<TreeNode<T>>{

  protected T data;
  
  protected TreeNode<T> left, right, parent;
  
  protected int h;
  
  protected int hh;
  
  public TreeNode(T data) {
    this.data = data;
    this.h = 1;
    this.hh = 1;
  }
  
  @Override
  public int compareTo(TreeNode<T> o) {
    return this.data.compareTo(o.data);
  }
  
  public TreeNode<T> setLeft(TreeNode<T> node){
    if (node == null) {
      this.left = null;
      return null;
    }
    this.left = node;
    node.parent = this;
    return this.left;
  }
  
  public TreeNode<T> setRight(TreeNode<T> node){
    if (node == null) {
      this.right = null;
      return null;
    }
    this.right = node;
    node.parent = this;
    return this.right;
  }
  
  protected boolean isLeaf() {
    return this.left == null && this.right == null;
  }
  
  protected void resetH() {
    this.h = Math.max(getH(this.left), getH(this.right)) + 1;
  }
  
  private int getH(TreeNode<T> node) {
    return node == null ? 0 : node.h;
  }
  
  public void show(float x, float y, float r){
    stroke(0);
    fill(255);
    circle(x, y, 2*r);
    fill(0);
    textAlign(CENTER, CENTER);
    text(String.valueOf(this.data), x, y);
    text(this.h, x, y-1.7f*r);
  }
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BST" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
