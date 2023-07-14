import java.util.HashMap;
import java.util.Map;

// Runtime
// Details
// 18ms
// Beats 26.03%of users with Java
// Memory
// Details
// 43.83mb
// Beats 8.00%of users with Java
public class isomophicString244 {
    public boolean isIsomorphic(String s, String t) {
        
        if(s.length() != t.length()) return false ;
        Map<Character , Character > map = new HashMap() ;
        Set<Character> tick = new HashSet() ;

        for(int i = 0; i < s.length() ; i++) {
            char si = s.charAt(i ) ;
            char ti = t.charAt(i) ;

            if(tick.contains(ti) && map.containsKey(si) == false ){
                return false ;
            }
            map.put(si,ti );
            tick.add(ti) ;
        }
        StringBuilder sb= new StringBuilder()  ;
        for(int i = 0; i < s.length() ; i++) {
            char si = s.charAt(i ) ;
            sb.append(map.get(si )) ;
        }
        return sb.toString.equals(t) ;

    }
}
