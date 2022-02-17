public class _747_LagestNumAtLeastTwice {
    public int dominantIndex(int[] nums) {
        if (nums.length == 0) return -1;
        if (nums.length == 1) return 0;


        int largest = nums[0];
        int secLargest = -1;
        int ind = 0;

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] >= largest) {
                secLargest = largest;
                largest = nums[i];
                ind = i;
            }
        }
        if (secLargest == -1 || (secLargest != 0 && largest / secLargest < 2) ) return -1;
        return ind;
    }
}
