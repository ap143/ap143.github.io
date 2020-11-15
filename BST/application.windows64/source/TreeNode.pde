

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
  
  void show(float x, float y, float r){
    stroke(0);
    fill(255);
    circle(x, y, 2*r);
    fill(0);
    textAlign(CENTER, CENTER);
    text(String.valueOf(this.data), x, y);
    text(this.h, x, y-1.7*r);
  }
  
}
