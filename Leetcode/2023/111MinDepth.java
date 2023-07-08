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
    public int minDepth(TreeNode root) {
        if(root ==null ) return 0;
        return  minDepthOfLeafOnly(root) ;
    }

    public int minDepthOfLeafOnly(TreeNode root) {
        if(root ==null ) return 9999999;
        if(root!= null && root.right ==null && root.left ==null) return 1 ;
        return Math.min(minDepthOfLeafOnly(root.right) , minDepthOfLeafOnly(root.left)) + 1 ;       
    }
//     Runtime
// 11 ms
// Beats
// 48.29%
// Memory
// 62.6 MB
// Beats
// 35.58%
}