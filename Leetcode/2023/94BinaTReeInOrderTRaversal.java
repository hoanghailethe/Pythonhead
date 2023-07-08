import java.util.List;

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
    public List<Integer> inorderTraversal(TreeNode root) {
        Queue<Integer    > intStack = new LinkedList<>(); 
        Stack<TreeNode > nodeStack = new Stack<>(); 
        List<Integer> res = new ArrayList<>() ;

        nodeStack.push(root) ;

        while(nodeStack.isEmpty()==false){
            TreeNode node = nodeStack.pop() ;
            if(node!=null){
                System.out.println(node.val) ;
                intStack.add(node.val) ;
                if (node.right != null) {
                    nodeStack.push(node.right); 
                }

                if(node.left!=null) {
                    nodeStack.push(node.left) ;
                }

            }
            
        }

        while(intStack.isEmpty() ==false) {
            res.add(intStack.poll());            
        }
        return res ;
    }
}