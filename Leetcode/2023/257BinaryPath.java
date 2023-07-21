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
    public List<String> binaryTreePaths(TreeNode root) {
        List <String> res = new ArrayList() ;

        addPath(root , "" , res) ;

        return res ;
    }

    public void addPath (TreeNode node , String s , List res ){
        if(node == null) return ;

        if(node.right == null && node.left == null) {
            res.add(s) ;
            return ;
        } 
        
        s += "->" + node.val ;
        addPath(node.left, s , res ) ;
        addPath(node.right, s, res);

    }
//     8ms
// Beats 60.97%of users with Java
// Memory
// Details
// 41.94mb
// Beats 29.36%of users with Java
}