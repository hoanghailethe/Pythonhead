public class 543DiameterBinaTree {

    ArrayList<Integer> bestOftheBest = new ArrayList<>()  ;
    public int diameterOfBinaryTree(TreeNode root) {

        loadUpLength(root);
        Collections.sort(bestOftheBest, Collections.reverseOrder());
        return bestOftheBest.get(0) ;
        
    }


    public int maxLengthTree(TreeNode root) {
        if(root == null) return 0 ;
        return  Math.max(1 + maxLengthTree(root.left) , 1+ maxLengthTree(root.right))  ;

    }

    public void loadUpLength(TreeNode root ) {
        if(root == null )return ;
        int res = 0 ;

        if(root.left !=  null ) res += maxLengthTree(root.left) ;
        if(root.right != null ) res += maxLengthTree(root.right) ;

        bestOftheBest.add(res) ;

        loadUpLength(root.left) ;
        loadUpLength(root.right) ;
        
    }

//     Runtime
// Details
// 9ms
// Beats 18.33%of users with Java
// Memory
// Details
// 43.61mb
// Beats 5.35%of users with Java


}
