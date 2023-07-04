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

        public boolean buddyStrings2(String s, String goal) {

            int n = s.length();
            if (s.equals(goal)) {
                Set<Character> temp = new HashSet<>();
                for (char c : s.toCharArray()) {
                    temp.add(c);
                }
                return temp.size() < goal.length(); // Swapping same characters
            }

            int i = 0;
            int j = n - 1;

            while (i < j && s.charAt(i) == goal.charAt(i)) {
                i++;
            }

            while (j >= 0 && s.charAt(j) == goal.charAt(j)) {
                j--;
            }

            if (i < j) {
                char[] sArr = s.toCharArray();
                char temp = sArr[i];
                sArr[i] = sArr[j];
                sArr[j] = temp;
                s = new String(sArr);
            }

            return s.equals(goal);
        }

        public boolean buddyStrings3(String s, String goal) {
            if(s == null || goal == null || s.length() != goal.length() || s.length() < 2){
                return false;
            }
            if(s.equals(goal)){
                int[] map = new int[26];
                for(int i = 0; i < s.length(); i++){
                    if(map[s.charAt(i) - 'a'] == 1){
                        return true;
                    }else{
                        map[s.charAt(i) - 'a'] = 1;
                    }
                }
            }
            char[] s1 = s.toCharArray();
            char[] s2 = goal.toCharArray();
            char s1_1 = '1', s1_2 = '2', s2_1 = '3', s2_2 = '4';
            boolean found1stDiff = false;
            boolean found2ndDiff = false;

            for(int i = 0; i < s1.length; i++){
                if(s1[i] != s2[i]){
                    if(!found1stDiff){
                        found1stDiff = true;
                        s1_1 = s1[i];
                        s2_1 = s2[i];
                    }else if(!found2ndDiff){
                        found2ndDiff = true;
                        s1_2 = s1[i];
                        s2_2 = s2[i];
                        if(s1_2 != s2_1 || s1_1 != s2_2){
                            return false;
                        }
                    }else{
                        return false;
                    }
                }
            }
            return found1stDiff && found2ndDiff;
        }
}
