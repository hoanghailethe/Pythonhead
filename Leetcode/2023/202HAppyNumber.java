import java.util.HashSet;
import java.util.Set;

// Runtime
// 1 ms
// Beats
// 90.24%
// Memory
// 39.6 MB
// Beats
// 65.12
class Solution {
    Set<Integer> set = new HashSet<>() ;
    public boolean isHappy(int n) {
        // System.out.println(n) ;

        if (n == 1 ) return true ;

        if (set.contains(n))return false ;
        else set.add(n);

        int newN = 0;
        while (n >= 1) {
            newN += (int)Math.pow(n %10, 2 ) ;
            n/=10;
        }

        return isHappy(newN );

        
    }
}