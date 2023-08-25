public class 2778SumSqu {
    public int sumOfSquares(int[] nums) {
        int len = nums.length ;
        int res = 0 ;
        for(int i = 0 ; i < len ;  i++   ) {
            int id =i+1;
            if(len%id==0) res+=nums[i]*nums[i];
        }
        return res ;
    }
//     Runtime
// Details
// 1ms
// Beats 100.00%of users with Java
// Memory
// Details
// 43.03MB
// Beats 82.47%of users 

}
