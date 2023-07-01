public class 70ClimbingStait {
    public int climbStairs(int n) {
        if(n==1) return 1 ;
        if(n==2) return 2 ;


        
        return climbStairs ( n -2 )  + climbStairs(n-1)  ;  
    
    }

//     Time Limit Exceeded
// 31 / 45 testcases passed
// Last Executed Input
// Use Testcase
// n =
// 45

    public int climbStairs2 (int n) {
        // if(n==1) return 1 ;
        // if(n==2) return 2 ;

        int[] cache = new int[n+1] ;
        cache[1] = 1;
        cache[2] = 2 ;
        return climbStairsCache ( n , cache ) ;  
    
    }

    public int climbStairsCache (int n, int[] cache) {
        if(n > 2 ) {
            climbStairsCache ( n-1 , cache ) ;
            cache[n] = cache[n-2] + cache[n-1] ;
        }
        return cache[n] ;
    }

//     Sorry, there are not enough accepted submissions to show data
// Runtime
// 0 ms
// Beats
// 100%
// Memory
// 39.8 MB
// Beats
// 14.46%

    // non RECUR
    public int climbStairs(int n) {
        if(n==1) return 1;
        
        if(n==2) return 2;

        int[] a =  new int[n];
        a[0]=1;
        a[1]=2;

        for(int i=2;i<n;i++){
            a[i]=a[i-1]+a[i-2];
        }
        return a[n-1];
    }
    
}
