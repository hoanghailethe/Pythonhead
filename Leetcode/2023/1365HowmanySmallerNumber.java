public class 1365HowmanySmallerNumber {
    public int[] smallerNumbersThanCurrent(int[] nums) {
        
        int[]countNum= new int[101] ;

        for(int num :  nums) {
            countNum[num]++ ;
        }


        Map<Integer, Integer>map =new HashMap() ;
        int accSum = 0 ;
        int[] res = new int[nums.length]  ;

        int[] sortNums =nums.clone();
        Arrays.sort(sortNums) ;
        map.put(sortNums[0] ,accSum) ;

        for(int i = 0 ;  i < nums.length-1 ; i++ ) {
            
            if(sortNums[i] <sortNums[i+1]) {
                accSum = accSum+ countNum[ sortNums[i] ] ;
                map.put(sortNums[i+1] ,accSum) ;
            }
            
        }

        for(int i = 0 ;  i < nums.length ; i++ ) {
            
            res[i] = map.get(nums[i]);
            
        }

        return res ;
    }
    Runtime
Details
5ms
Beats 81.36%of users with Java
Memory
Details
43.93mb
Beats 21.21%of users with Java


}
