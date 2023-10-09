class Solution {
    public int findLHS(int[] nums) {
        int sameNumTreak = 1 ;
        int curHarmoniousTreak = 0 ;
        Integer prev = null ;
        int maxTreak = 0;

        Integer first = null ; 
        Integer sec = null ; 

        for(int num: nums) {
            if( prev != null && prev == num ) sameNumTreak++; 

            if(first == null ) {
                first = num ;
                curHarmoniousTreak++ ;
            }
            else if (sec == null ) {
                if(Math.abs(first-num)==1) {
                    sec = num ;
                    curHarmoniousTreak++ ;
                }
                else first = sec;
            } else if (num == first || num == sec ) {
                curHarmoniousTreak++ ;

            } else if (Math.abs(sec- num )==1) {
                curHarmoniousTreak = sameNumTreak + 1 ; 
            }
 
            maxTreak =Math.max(maxTreak, curHarmoniousTreak) ;
            prev = num ;

        }


        return maxTreak; 
    }

    public int findLHS(int[] nums) {
        HashMap <Integer, Integer > map = new HashMap() ;

        for(int num : nums ) {
            map.put(num , map.getOrDefault(num , 0 ) + 1  ) ;

        }

        int maxStreak = 0 ;

        for(int num : map.keySet() ) {
            if( map.keySet().contains(num+1) ) {
                maxStreak=Math.max(maxStreak, map.get(num ) + map.get(num+1) ) ;
            }

            
        }
        return maxStreak ;
    }

Runtime
Details
18ms
Beats 32.38%of users with Java
Memory
Details
44.16MB
Beats 66.94%of users with Java
    public int findLHS(int[] nums) {
        if(nums.length==0){
            return 0;
        }
        Arrays.sort(nums);
        int left=0,right=1;
        int arry=0;
        while(right<nums.length){
            int diff=nums[right]-nums[left];
            if(diff==1){
                arry=Math.max(arry,right-left+1);
            }
            if(diff<=1){
                right++;
            }else{
                left++;
            }
           
        }
         return arry;
    }

}