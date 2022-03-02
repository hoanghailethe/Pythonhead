public class _392_isSubsequence {

//     Runtime: 1 ms, faster than 88.36% of Java online submissions for Is Subsequence.
// Memory Usage: 42.6 MB, less than 8.83% of Java online submissions for Is Subsequence.
    public boolean isSubsequence(String s, String t) {

        if(t.length() < s.length()) return false; 

        int t_ind = 0, s_ind = 0; 
        
        for (int i = 0 ; i < s.length() ; i++) {

            char letter = s.charAt(i);
            for (int j = t_ind ; j < t.length() ; j++ ) {
                if (letter == t.charAt(j)) {
                    t_ind = j + 1;
                    s_ind = i;
                    break;
                }
                else if ( j == t.length() - 1 ) return false;
            }

             // check if the end of s not reached but end of t reached - left some element:
            //  if ( i == s.length() - 1 && t_ind != t.length() - 1) return false;
        }   

        return s_ind == s.length() - 1;
    }
}
