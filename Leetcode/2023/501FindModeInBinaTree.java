class Solution {
    Runtime
Details
6ms
Beats 36.50%of users with Java
Memory
Details
45.08mb
Beats 10.39%of users with Java

     public int[] findMode(TreeNode root) {
        HashMap<Integer, Integer> map = new HashMap() ;

        collectCount(map, root) ; 

        List<Integer> res = new ArrayList<>() ; 
        int maxCount = 0 ;
        for(int key : map.keySet() ) {

            // maxCount = Math.max(maxCount , map.get(key)) ;
            if( map.get(key) > maxCount ) {
                res = new ArrayList<>() ;
                res.add(key) ;
                maxCount = map.get(key) ;
            } else if (map.get(key) == maxCount) {
                res.add(key) ;
            }
        }
        
        int [] resArr = new int[res.size()] ;
        for(int i = 0 ; i < resArr.length ; i++) {
            resArr[i] = res.get(i) ;
        } 
        return resArr ;

    }

    public void collectCount(Map<Integer, Integer> map , TreeNode root ) {
        if (root == null) return ;
        map.put(root.val , map.getOrDefault(root.val, 1 ) + 1) ;
        collectCount(map, root.left ) ;
        collectCount(map, root.right ) ;
    }
}