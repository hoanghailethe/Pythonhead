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
//     Runtime4 ms
// Beats
// 5.59%
// Memory
// 41 MB
// Beats
// 45.35%
    public List<Integer> inorderTraversal(TreeNode root) {
        Queue<Integer    > intStack = new LinkedList<>(); 
        Stack<TreeNode > nodeStack = new Stack<>(); 
        List<Integer> res = new ArrayList<>() ;

        nodeStack.push(root) ;

        while(nodeStack.isEmpty()==false){
            TreeNode node = nodeStack.pop() ;
  
            if(node != null ) {
                nodeStack.push(node.left) ;
                System.out.println(node.val) ;
                intStack.add(node.val) ;
                            nodeStack.push(node.right); 
            }

        }

        while(intStack.isEmpty() ==false) {
            res.add(intStack.poll());            
        }
        return res ;
    }

    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> nodes = new LinkedList<>();
        
        if (root == null) {
            return nodes;
        }

        nodes.add(root.val);
        nodes.addAll(preorderTraversal(root.left));
        nodes.addAll(preorderTraversal(root.right));

        return nodes;
    }
}