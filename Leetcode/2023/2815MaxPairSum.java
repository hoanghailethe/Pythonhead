import java.util.Map;
import java.util.Set;

class Solution {
    public int maxSum(int[] nums) {
        int res = -1 ;

        Integer[] numsCopy = new Integer[nums.length] ;
        for(int i = 0 ; i<nums.length; i++) {
            numsCopy[i] = nums[i]; 
        }
        Arrays.sort(numsCopy, Collections.reverseOrder());

        Map<Integer, List> map = new HashMap();


        for(int num : numsCopy) {

            int numCopy = num ;
            int maxDigit = 0;
            while(num>0) {

                maxDigit = Math.max(maxDigit, num % 10 );
                num /=10 ;
            }

            List <Integer>numsSameSum =  map.getOrDefault(maxDigit, new ArrayList<Integer>() ) ;

            if(numsSameSum.size() < 2 ) {
                numsSameSum.add(numCopy) ;
                map.put(maxDigit, numsSameSum) ;
                if( numsSameSum.size() == 2 ) {
                    Integer sum = numsSameSum.stream().reduce((x, y) -> x + y).get();
                    res = Math.max(res , sum) ;
                }
            }       
        }

        return res ;
    }
//     Runtime
// Details
// 15ms
// Beats 57.18%of users with Java
// Memory
// Details
// 43.70MB
// Beats 64.65%of users with Java
}