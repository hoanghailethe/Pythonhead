class Solution {
    public char nextGreatestLetter(char[] letters, char target) {
        char res = letters[0];
        int dif = 1000 ;

        for (char c : letters ){
            if( c  >  target && c - target  < dif ) {
                dif = c - target ;
                res = c;
            }
        }

        return res ;
    }
    Runtime
Details
0ms
Beats 100.00%of users with Java
Memory
Details
43.85MB
Beats 95.08%

}