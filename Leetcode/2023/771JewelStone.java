class Solution {
    public int numJewelsInStones(String jewels, String stones) {
        int[] checkJewCode =    new int[128 ] ;
        int countJew = 0 ;
        
        for (char jew : jewels.toCharArray()) {
            checkJewCode[jew]++ ;
        }

        for(char stone : stones.toCharArray()) {
            if(checkJewCode[stone]>0  )countJew++ ;
        }
        return countJew;
    }
//     Runtime
// Details
// 0ms
// Beats 100.00%of users with Java
// Memory
// Details
// 40.66MB
// Beats 79.81%of users with Java
}