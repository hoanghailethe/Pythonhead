class Solution {
    public int dominantIndex(int[] nums) {
        int res = -1 ;

        int max = Integer.MIN_VALUE ;
        int sec =  Integer.MIN_VALUE ;


        for(int i = 0 ; i< nums.length; i++) {


            if (max < nums[i]) {
                if(max!= Integer.MIN_VALUE) sec = max ;    
                max = nums[i]         ;
                res  = i ;
            }else {
                sec = Math.max(sec, nums[i]) ;
            }

        }

        return sec == 0 || max/ sec >= 2 ?  res : -1  ; 
    }
//     Runtime
// Details
// 0ms
// Beats 100.00%of users with Java
// Memory
// Details
// 40.30MB
// Beats 74.68%of users with Java

}