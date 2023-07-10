public class 112PAthSum {
// Runtime
// 1 ms
// Beats
// 9.38%
// Memory
// 43.4 MB
// Beats
// 51.67%
    ArrayList<Integer> sums= new ArrayList<>() ;
    public boolean hasPathSum(TreeNode root, int targetSum) {

        calculateSum (root, 0) ;
        return sums.contains(targetSum) ;

    }

    public void calculateSum(TreeNode node, int parentSum ) {
        //base case: leaf reached and the current path's total equals to given value of 'target
        if (node == null) return ;

        int sum = parentSum + node.val ;
        
        if(isLeaf(node)) {
            sums.add(sum);
        } else {
            calculateSum(node.left, sum );
            calculateSum(node.right, sum ) ;
        }
    }

    public boolean isLeaf(TreeNode node) {
        return (node!=null && node.right == null && node.left == null);
    }

    //method2 :
// Runtime
// 0 ms
// Beats
// 100%
// Memory
// 43.7 MB
// Beats
// 27.13%
    public boolean hasPathSum(TreeNode root, int targetSum) {

        return delegateChildPathSum (root, 0, targetSum) ;


    }

    public boolean delegateChildPathSum(TreeNode root,int accumulateSum, int targetSum) { 
        if(root==null){ 
            return false ;
        }
        int newAccSum = accumulateSum + root.val ;

        if(isLeaf(root)) return newAccSum == targetSum ; 

        return delegateChildPathSum(root.right, newAccSum, targetSum)|| delegateChildPathSum(root.left, newAccSum, targetSum);
    }
}
