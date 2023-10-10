class Solution {
    public double findMaxAverage(int[] nums, int k) {
        int firstKSum = 0 ;

        for(int i = 0 ; i < k ; i++) {
            firstKSum+=nums[i] ;
        }

        int maxSum = firstKSum ;

        for(int i = k; i< nums.length ; i++) {
            firstKSum = firstKSum + nums[i] - nums[i-k] ;
            maxSum = Math.max(maxSum, firstKSum ) ;
        } 

        double res = maxSum*1d / k  ;

        return res ;
    }
}

Runtime
Details
2ms
Beats 100.00%of users with Java
Memory
Details
54.14MB
Beats 72.86%of users with Java