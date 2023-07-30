class Solution {
//     Runtime
// Details
// 2ms
// Beats 61.49%of users with Java
// Memory
// Details
// 40.42mb
// Beats 76.03%of users with Java
    public boolean isSubsequence(String s, String t) {
        int si = 0 ;
        // int ji =0 ;

        for(int ti = 0 ; ti < t.length() && si < s.length() ; ti++) {

            if(t.charAt(ti) == s.charAt(si) ) si++ ;
        }
        return si == s.length() ;


    }
}