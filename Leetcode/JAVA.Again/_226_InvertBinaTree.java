public class _226_InvertBinaTree {
    public TreeNode invertTree(TreeNode root) {
        if (root == null) return null;

        swapLeftRight(root);
        invertTree(root.left);
        invertTree(root.right);

        return root;

    }

    public void swapLeftRight(TreeNode node) {

        TreeNode left = node.left ; 
        TreeNode right = node.right ;

        node.right = left;
        node.left = right;
    }
}
// Runtime: 0 ms, faster than 100.00% of Java online submissions for Invert Binary Tree.
// Memory Usage: 41.6 MB, less than 33.60% of Java online submissions for Invert Binary Tree.

 public class TreeNode {
      int val;
      TreeNode left;
      TreeNode right;
      TreeNode() {}
      TreeNode(int val) { this.val = val; }
      TreeNode(int val, TreeNode left, TreeNode right) {
          this.val = val;
          this.left = left;
          this.right = right;
      }
  }
