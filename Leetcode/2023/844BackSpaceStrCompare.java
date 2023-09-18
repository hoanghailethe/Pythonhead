public class 844BackSpaceStrCompare {
    public boolean backspaceCompare(String s, String t) {
        StringBuilder sb = new StringBuilder() ;

        for (char c : s.toCharArray()) {
            if(c!='#') sb.append(c) ;
            else {
                if(sb.length() > 0) {
                    sb.deleteCharAt(sb.length() - 1);
                }        
            }
        }

        String resS = sb.toString() ;
        sb.setLength(0) ;

        for (char c : t.toCharArray()) {
            if(c!='#') sb.append(c) ;
            else {
                if(sb.length() > 0) {
                    sb.deleteCharAt(sb.length() - 1);
                }        
            }
        }

        String resT = sb.toString() ;

        return resS.equals(resT) ;
    }

//     Runtime
// Details
// 1ms
// Beats 84.62%of users with Java
// Memory
// Details
// 40.68MB
// Beats 50.42%of users with Java
}
