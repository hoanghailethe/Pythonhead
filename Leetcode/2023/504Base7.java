class Solution {
    Runtime
Details
1ms
Beats 70.13%of users with Java
Memory
Details
40.38mb
Beats 32.75%of users with Java

    public String convertToBase7(int num) {
        if(num == 0) return "0" ;
        StringBuilder sb= new StringBuilder()  ;

        int numAbs =Math.abs(num) ;

        while (numAbs > 0 ) {
            sb.insert(0 , numAbs % 7 ) ;
            numAbs /= 7 ; 
        }
        if(num < 0) sb.insert(0 , '-' ) ;
        return sb.toString() ;
    }
}