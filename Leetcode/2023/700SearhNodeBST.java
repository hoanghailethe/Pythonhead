public class 700SearhNodeBST {
    public TreeNode searchBST(TreeNode root, int val) {
        if(root== null)return null;
        if( root.val == val )return root;
        TreeNode res = null ;
        if(val > root.val ) res = searchBST(root.right, val) ;
        else res = searchBST(root.left, val) ;
        return res ;
    }

//     Runtime
// Details
// 0ms
// Beats 100.00%of users with Java
// Memory
// Details
// 44.06MB
// Beats 38.76%of users with Java
}
