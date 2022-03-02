public class _908_smallestRange1 {
//     Runtime: 1 ms, faster than 100.00% of Java online submissions for Smallest Range I.
// Memory Usage: 50.2 MB, less than 6.22% of Java online submissions for Smallest Range I.
    public int smallestRangeI(int[] nums, int k) {
        // find mã and min inside 1 looping round
        int max= nums[0], min = nums[0];

        for (int num : nums) {
            if (max < num) max = num;
            else if (min > num) min = num;
        }

        for (int num : nums) {
            if ( Math.abs((num + k) -max) > Math.abs(min + k - num) ) min = Math.min(min + k, num);
            else max = Math.max(max - k , num );
        }
        System.out.println(max);
        System.out.println(min);
        

        return max - min ;
    }
}


// Your input
// [1, 3, 6]
// 3
// stdout
// 3
// 6

// Output
// -3
// Expected
// 3
