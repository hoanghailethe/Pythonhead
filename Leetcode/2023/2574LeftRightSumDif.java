public class 2574LeftRightSumDif {
    public int[] leftRightDifference(int[] nums) {

        int[]leftSumArr =  new int [nums.length] ;
        int[]rightSumArr =  new int [nums.length] ;
        for(int i = 0 ; i < nums.length ; i++) {
            if(i-1 >= 0 ) {
                leftSumArr[i] =    leftSumArr[i-1] +nums[i-1] ;
            }

            if(  nums.length-1  - i + 1 < nums.length ) {
                rightSumArr[nums.length-1  - i] = rightSumArr[nums.length-1  - i + 1] + nums[nums.length-1  - i + 1] ;
            }
        }
        int[]res =  new int [nums.length] ;
        for(int i = 0 ; i < nums.length ; i++) {  
            System.out.print( i+ " " +leftSumArr[i] + " "  +rightSumArr[i] )    ;     
            res[i] += Math.abs(leftSumArr[i]-rightSumArr[i] ) ;
        }
        return res ;
    }

    3ms
Beats 24.53%of users with Java
Memory
Details
43.95mb
Beats 32.17%of users with Java
}
