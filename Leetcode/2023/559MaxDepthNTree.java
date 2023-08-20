public class 559MaxDepthNTree {
    public int maxDepth(Node root) {
        if(root == null) return 0 ;
        
        int maxDep =  0 ;
        for(Node child : root.children) {
            maxDep=Math.max(maxDep, maxDepth(child)) ;
        }
        return maxDep + 1;

    }
//     Runtime
// Details
// 0ms
// Beats 100.00%of users with Java
// Memory
// Details
// 42.45MB
// Beats 99.16%of users with Java
}
