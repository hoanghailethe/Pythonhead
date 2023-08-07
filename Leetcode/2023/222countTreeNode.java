class Solution {
    public int countNodes(TreeNode root) {
        if(root == null ) return 0 ;
        return 1 + countNodes(root.left) + countNodes(root.right) ;
    }
    Runtime
Details
-ms
Beats 100.00%of users with Java
Memory
Details
45.75mb
Beats 66.09%of users with Java
}