public class 434NumberSegmentinStr {
    public int countSegments(String s) {
        if ("".equals(s)) return 0 ;

        String[] sArr =  s.split(" ") ;
        int res = 0 ;
        for(String ss: sArr) {
            if (" ".equals(ss) == false) res ++ ;
        }
        return res ;
    }

//     Runtime
// Details
// -ms
// Beats 100.00%of users with Java
// Memory
// Details
// 40.30mb
// Beats 63.48%of users with Java
}
