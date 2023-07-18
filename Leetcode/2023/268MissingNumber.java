public class 268MissingNumber {.
//     Runtime
// Details
// -ms
// Beats 100.00%of users with Java
// Memory
// Details
// 44.22mb
// Beats 56.43%of users with Java
    public int missingNumber(int[] nums) {
        boolean[] numId = new boolean[nums.length] ;
        for( int num : nums ) {
            numId[num] = true ;
        }

        for(int x = 0; x < nums.length ; x++) {
            if(numId[x] == false) return x;
        }
        return -1 ;
    }
}
