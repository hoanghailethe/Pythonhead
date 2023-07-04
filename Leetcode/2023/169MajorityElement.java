class Solution {
    public int majorityElement(int[] nums) {
        HashMap<Integer, Integer > map = new HashMap<>() ;
        int avg= nums.length /2 ;

        for(int num : nums) {
            if (map.getOrDefault(num , 0 ) + 1 > avg) return num ;
            map.put(num, map.getOrDefault(num , 0 ) + 1) ;
        }
        return 0 ;
    }
}