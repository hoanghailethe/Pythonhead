public class 561ArrPatrition {
    public int arrayPairSum(int[] nums) {
        Arrays.sort(nums) ;

        int sum = 0 ;

        for(int i = 0; i < nums.length ; i+= 2) {
            sum+= nums[i];
        }
        return sum ;
    }
//     Runtime
// Details
// 12ms
// Beats 95.26%of users with Java
// Memory
// Details
// 45.50mb
// Beats 22.04%of users with Java
}
