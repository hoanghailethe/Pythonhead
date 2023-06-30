public class 283moveZero {
    
    // Wrong understand
    public void moveZeroes2(int[] nums) {
    
        int nonZeroInd = -1 ;
            // nums.length() - 1; 
        Queue<Integer> zeroId = new LinkedList<>() ;

        for(int i = nums.length -1 ; i >= 0 ; i-- ) {
            if(nums[i] == 0 ) {
                if ( nonZeroInd >= i) zeroId.add(i) ;
            } else if( nonZeroInd == -1 ){
                 nonZeroInd = i ;
            }
        }

        System.out.println(zeroId) ;
 
        while( nonZeroInd > 0 && zeroId.isEmpty() == false ) {
            int zid = zeroId.poll() ;

            if(nonZeroInd > zid ) {
                // swap(nums, nonZeroInd , zid) ;
                // swap
                int tempt = nums[nonZeroInd] ;
                nums[nonZeroInd ] = nums[zid] ;
                nums[zid] = tempt ;

            }

            nonZeroInd = zid - 1; 

        }

   }

    public void moveZeroes2(int[] nums) {

        double[] total = new double[nums.length+1] ;

         for(int i = 0; i < nums.length ; i++) {
            total[0] += nums[i];
        }

        int end = 0 ;

        for(int i = 0; i < nums.length ; i++ ) {
            if (nums[i ]!= 0){
                total[end+1] += total[end]+ nums[i] ;
                end++ ;
            }
        
        }

       

        // int c = total[0] ;

        for(int i = 0; i < nums.length  ; i++) {
            if(i<end) nums[i] = (int)(total[i+1]-total[i]) ;
            else nums[i] = 0 ;
        }

    }

//     Runtime
// 2 ms
// Beats
// 40.94%
// Memory
// 44.6 MB
// Beats
// 70.95%

public void moveZeroes3(int[] nums) {
        int snowBallSize = 0; 
        for (int i=0;i<nums.length;i++){
	        if (nums[i]==0){
                snowBallSize++; 
            }
            else if (snowBallSize > 0) {
	            int t = nums[i];
	            nums[i]=0;
	            nums[i-snowBallSize]=t;
            }
        }
    }
}
