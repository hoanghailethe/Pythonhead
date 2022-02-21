public class _896_monotonicArray {
//     Runtime: 1 ms, faster than 99.96% of Java online submissions for Monotonic Array.
// Memory Usage: 52.5 MB, less than 74.45% of Java online submissions for Monotonic Array.
    public boolean isMonotonic(int[] nums) {
        int pre = 0 ; 

        for (int i = 1 ; i < nums.length ; i++) {
            int deviation = nums[i] - nums[i-1] ;
            //if (deviation == 0) return false;

            if (pre != 0 && deviation * pre < 0) {
                return false;
            }
            if (deviation != 0 ) pre = deviation;
        }

        return true;
    }
}
