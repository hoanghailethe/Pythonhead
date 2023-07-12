public class 509fiboNum {
//    Runtime
// 12 ms
// Beats
// 5%
// Memory
// 39.8 MB
// Beats
// 6.70% 
    int[] fibo = new int[31];
    
    public int fib(int n) {
        if( n <= 1) return n ;
        else {
            fibo[n] = fib(n-1) +fib(n-2) ;
        }
        return  fibo[n];
    }


}
