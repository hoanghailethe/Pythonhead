public class Calculator {
    public int Average (Integer[] nums) {
        if (nums.length == 0) return 0;
        int sum = 0 ;
        for (Integer num : nums) {
            sum += num;
        }
        return sum / nums.length ;
    }

}