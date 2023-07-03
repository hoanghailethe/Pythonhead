public class 859BuddyString {
//     Runtime
// 3 ms
// Beats
// 65.16%
// Memory
// 41.4 MB
// Beats
// 92.92%
    public boolean buddyStrings(String s, String goal) {
        int n = s.length() ;

        if(goal.length() != n) return false ;

        char[] sc = new char[2] ;
        char[] gc = new char[2] ;
        
        int charDifCount = 0 ;

        //check 2 ky tu giong nhau ton tai
        int[] count = new int[256] ;
        for(int i = 0 ; i < n ; i++) {
            count[s.charAt(i)]++ ;
            // if(counts.charAt(i) == 2) return true ;

            if(s.charAt(i) != goal.charAt(i)) {
                charDifCount ++;
                if(charDifCount > 2) return false ;

                sc[charDifCount-1] = s.charAt(i) ;
                gc[charDifCount-1] = goal.charAt(i) ;

                System.out.println (s.charAt(i) + ", " + goal.charAt(i));
            }
        }

        if(charDifCount==2 && sc[0] == gc[1] && sc[1] == gc[0]) return true   ;
        else if(charDifCount == 0){
            for(int i = 0 ; i < n ; i++) {
                if(count[s.charAt(i)]>=2) return true ;
            }
        }    
        return false ;
    }
}
