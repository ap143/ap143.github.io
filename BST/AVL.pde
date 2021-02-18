

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
