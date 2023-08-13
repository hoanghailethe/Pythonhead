public class 606StringOFBina {
    public String tree2str(TreeNode root) {
        StringBuilder sb = new StringBuilder () ;

        sbTreeString(root, sb ) ;

        return sb.toString() ;
    }

    public void sbTreeString(TreeNode node, StringBuilder sb ) {
        if(node == null )return ;
        else sb.append(node.val )  ;
        if(node.left!=null||(node.left==null && node.right!=null)) {
            sb.append('(') ;
            sbTreeString(node.left,sb);
            sb.append(')') ;
        }
        
        if(node.right!=null) {
            sb.append('(') ;
            sbTreeString(node.right,sb);
            sb.append(')') ;
        }
        
    } 

//     Runtime
// Details
// 1ms
// Beats 100.00%of users with Java
// Memory
// Details
// 43.27mb
// Beats 90.13%of users with Java

}
