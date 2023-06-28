class Solution {
    public int mySqrt(int x) {
        // find n that n * n < x but (n+1) ^ 2 > x
        if (x <= 1) return x ;

        return binarySearchHaft(x, 1 , x - 1 ) ;
    }

    public int binarySearchHaft(int x, int l, int r ) {
        
        if (l + 1 >= r ) return l ;

        int m = (l + r ) / 2 ;

        if (x == m * m ) return m ;
        else if( x < m * m ) return binarySearchHaft(x, l , m ) ;
        else return binarySearchHaft(x, m , m + 1 + (r-m) / 2 ) ; 

    } 

    // 2147395599
}