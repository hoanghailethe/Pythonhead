public class 653TwoSumVI {

    Set<Integer>map = new HashSet<>() ;
    public boolean findTarget(TreeNode root, int k) {
        if( root==null)return false;
        if( map.contains(k - root.val) ) return true ;

        map.add(root.val);
        return findTarget(root.left, k) || findTarget(root.right, k);

    }
    Runtime
Details
2ms
Beats 98.00%of users with Java
Memory
Details
43.67mb
Beats 80.71%of users with Java

}
