public class 326PowerofThree {
    public boolean isPowerOfThree(int n) {
       if(n == 1) return true ;
        if(n <= 0 || n % 3 != 0) return false ;
        return isPowerOfThree(n/3);
    }
//     Runtime
// Details
// 16ms
// Beats 38.96%of users with Java
// Memory
// Details
// 42.99mb
// Beats 62.90%of users with Java
}
