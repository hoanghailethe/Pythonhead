class Solution {
    public String shortestCompletingWord(String licensePlate, String[] words) {
        int[]  checkLot = new int[125] ;
        for (char c : licensePlate.toLowerCase().toCharArray() ) {
            if(c>='a'&& c<='z')checkLot[c]++;
        }
        int minLen = Integer.MAX_VALUE ;
        String res = "" ;

        for(String w : words) {
            // System.out.print(w+ " ");
            int[] chkClone = checkLot.clone() ; 

            for(char c :w.toLowerCase().toCharArray()) { 
                if(c>='a'&& c<='z')chkClone[c]--;
            }

            boolean isValid= true ; 
            for(int time  : chkClone) {
            
                if(time>0) {
                    // System.out.print( time + "  ") ;
                    isValid = false ;
                    break ;
                }
            }

            if(isValid && minLen> w.length()) {
                minLen=w.length();
                res = w ;
            }
        }

        return res ;

    }

//     6ms
// Beats 64.46%of users with Java
// Memory
// Details
// 44.75MB
// Beats 6.61%of users with Java
}