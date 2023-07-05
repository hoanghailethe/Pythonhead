public class 110BalanceBinaryTree {
//     Runtime
// 1 ms
// Beats
// 94.16%
// Memory
// 43 MB
// Beats
// 75.75%
    public boolean isBalanced(TreeNode root) {

        if(root == null) return true;

        if(!(isBalanced(root.left) && isBalanced(root.right))) return false ;

        return (Math.abs(heightTree(root.left) - heightTree(root.right))<=1) ;
        
    }

    public int heightTree(TreeNode node) {
        if(node == null) return 0 ;
        return Math.max( heightTree(node.left), heightTree(node.right) ) + 1 ;
    }
}

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */