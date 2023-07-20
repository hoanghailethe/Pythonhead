public class 303RangeSumQuery {
    class NumArray {

        int[] nums;

        public NumArray(int[] nums) {
            this.nums = nums ;
        }
        
        public int sumRange(int left, int right) {
            int sum = 0 ;
            for (int i=left;i<=right;i++) {
                sum += this.nums[i] ;
            }
            return sum ;
        }
    }

    Runtime
Details
56ms
Beats 23.70%of users with Java
Memory
Details
48.96mb
Beats 18.24%of users with Java


}
