class Solution {
    public int longestPalindrome(String s) {
        int[] countChar =new int[128] ;

        char[] arr = s.toCharArray() ;

        for (char c : arr ) {

            countChar[c] ++ ;

        }

        int res = 0 ;

        for(int num : countChar ) {
            int div = num / 2 ; 
            res+= div*2; 
        }

        if(s.length() > res ) res += 1 ;

        return res ;
    }
//     Runtime
// Details
// 1ms
// Beats 100.00%of users with Java
// Memory
// Details
// 40.51mb
// Beats 94.86%of users with Java
}