public class 342PowerOFFOur {
    public boolean isPowerOfFour(int n) {

        if(n > 1 && n % 4 == 0) return isPowerOfFour(n/4);
        
        if(n == 1) return true ;
        
        return false ;   
    }

    Runtime
Details
1ms
Beats 100.00%of users with Java
Memory
Details
40.21mb
Beats 5.89%of users with Java

}
