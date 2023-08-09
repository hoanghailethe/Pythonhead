public class 530MinAbsVAlueDifNode {
    public int getMinimumDifference(TreeNode root) {
        Queue<Integer> q =   new LinkedList() ;

        loadToQueue(root, q) ;

        int minDif = Integer.MAX_VALUE ;
        int preVal= q.poll() ;
        while(q.isEmpty() == false )  {
            int curVal= q.poll() ;
            minDif=Math.min(minDif, Math.abs(preVal -curVal) );
            preVal =  curVal ;
        }

        return minDif ;
    }

    public void loadToQueue(TreeNode node,Queue q ) {
        if(node == null  ) return  ;
        loadToQueue(node.left,q) ;
        q.add(node.val) ;
        loadToQueue(node.right,q) ;
    }

//     Runtime
// Details
// 1ms
// Beats 62.51%of users with Java
// Memory
// Details
// 43.51mb
// Beats 25.18%of users with Java

}
