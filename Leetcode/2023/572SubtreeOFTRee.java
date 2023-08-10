public class 572SubtreeOFTRee {

    ArrayList<TreeNode> candidates = new ArrayList<>() ;
    
    public boolean isSubtree(TreeNode root, TreeNode subRoot) {
        
        findCandidate(root , subRoot.val) ;

        for(TreeNode node : candidates) {
          if(isSameTreeStructure (node , subRoot ))return true   ;
        }

        return false ;

    }

    public void findCandidate(TreeNode root , int val) {

        if(root == null) return ;

        if(root.val== val) candidates.add(root) ;
        findCandidate(root.right,val);
        findCandidate(root.left,val)  ;

    }

    public boolean isSameTreeStructure(TreeNode node1, TreeNode node2) {
        if (node1==null && node2==null) return true ;
        if(node1!=null&&node2!=null){
            if(node1.val != node2.val)return false ;

            return isSameTreeStructure(node1.left, node2.left) && isSameTreeStructure(node1.right, node2.right) ;

        }
        return false ;
    }
//     Runtime
// Details
// 3ms
// Beats 80.18%of users with Java
// Memory
// Details
// 43.62mb
// Beats 17.80%of users with Java

}
