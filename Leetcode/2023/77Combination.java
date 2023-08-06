class Solution {
    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> res = new ArrayList() ;

        int[] nArray = new int[n] ;

        for (int i = 0 ; i < nArray.length ; i ++ ) {
            // System.out.print( i + 1);
            nArray[i] = i + 1; 
        }

        int r = 0 ;
        // List<Integer> collector = new ArrayList () ;
        // collectCombine ( r , nArray , collector ,    res , k )  ; 
        
        for (int i = 0 ; i < nArray.length ; i ++ ) {
            List<Integer> collector = new ArrayList () ;

            collectCombine ( i , nArray , collector ,    res , k )  ; 
        }

        return res ;
    }

    public void collectCombine( int pos , int[] arr , List<Integer> collector ,  List<List<Integer>>res , int count  ) {
        if(count - 1 == 0 ) {
            collector.add(arr[pos]) ;
            res.add ( collector ) ;
            return ;
        }
        
        // for(int i = pos ; i < arr.length && count- pos >= 0 ; i++ ) {
            
            // count -= 1 ;
            for(int j = pos + 1 ; j < arr.length && count  >= 0 ; j++ ) {   
                List<Integer> copy = new ArrayList<>(collector);
                copy.add(arr[pos]) ;          
                collectCombine ( j ,  arr , copy , res , count - 1 ) ; 
            }
        // }
        
    }

//     Runtime
// Details
// 25ms
// Beats 22.36%of users with Java
// Memory
// Details
// 93.42mb
// Beats 5.12%of users with Java

}  

class Solution {
    private void generateCombinations(int[] nums, List<List<Integer>> result, List<Integer> current, int start, int k) {
        if (k == 0) {
            result.add(new ArrayList<>(current));
            return; // Base case: Stop recursion
        }

        for (int i = start; i <= nums.length - k; i++) {
            current.add(nums[i]);
            generateCombinations(nums, result, current, i + 1, k - 1);
            current.remove(current.size() - 1); // Backtrack by removing the last element
        }
    }

    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> result = new ArrayList<>();
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = i + 1;
        }
        generateCombinations(nums, result, new ArrayList<>(), 0, k);
        return result;
    }
}