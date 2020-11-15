

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
