class Solution {
    public int mySqrt(int x) {
        // find n that n * n < x but (n+1) ^ 2 > x
        if (x <= 1) return x ;

        return binarySearchHaft(x, 1 , x - 1 ) ;
    }

    public int binarySearchHaft(int x, int l, int r ) {
        
        if (l+1 >= r ) return l ;

        int m = l + ( r - l ) / 2 ;

        System.out.println(m);

        if (x/m == m ) return m ;
         else if( x/m < m ) return binarySearchHaft(x, l , m ) ;
        else return binarySearchHaft(x, m , r ) ; 
    } 

    // 2147395599

    public int mySqrt2(int x) {
        if(x == 0) // To avoid division by 0
            return 0;
        int start = 1, end = x / 2 + 1; // The squareroot can only lie in this range
        while(start <= end) {
            int mid = start + (end - start) / 2;
            if(mid == x / mid) // Not multiplying as the product for a large number may be greater than the max value of int
                return mid;
            else if(mid < x / mid) 
                start = mid + 1;
            else
                end = mid - 1;
        }
        return end; // end will be the largest integer such that end^2 < x
    }

}