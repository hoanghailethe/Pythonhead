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
class Solution {
//     Runtime
// 0 ms
// Beats
// 100%
// Memory
// 40.9 MB
// Beats
// 40.10%
    public boolean isSymmetric(TreeNode root) {

        if(root == null ) return true ;

        return isMirrored(root, root) ;
        
    }

    public boolean isMirrored( TreeNode node1, TreeNode node2) {
        if(node1 == null && node2 ==null) return true ;

        if (node1 != null && node2!=null)return isMirrored(node1.left, node2.right) && isMirrored(node1.right, node2.left) && node1.val == node2.val; 
        return false ;
    }
}