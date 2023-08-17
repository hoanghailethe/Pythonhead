public class 724FindPivotInd {
    public int pivotIndex(int[] nums) {
        int tsum = 0 ;
        for(int num: nums ) tsum += num ;

        if (tsum- nums[0]==0) return 0;
        int tsum2 =0 ;  
        
        for(int i=1;i<  nums.length; i++ ) {
            tsum2+= nums[i-1];
            if(tsum2== (tsum- tsum2 -nums[i])) return i ;
        }
        return -1 ;
    }

//     1ms
// Beats 99.67%of users with Java
// Memory
// Details
// 43.81mb
// Beats 88.92%of users with Java
}
