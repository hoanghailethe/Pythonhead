public class _1037_validBomerang {
    public boolean isBoomerang(int[][] points) {
        if ( points[1][1] - points[0][1] == 0 && ( points[2][1] - points[0][1] ) != 0) return true ; 
        if ( points[1][1] - points[0][1] != 0 && ( points[2][1] - points[0][1] ) == 0) return true ; 
        if ( points[1][1] - points[0][1] == 0 && ( points[2][1] - points[0][1] ) == 0) return false ; 
        long sinAngle01 =  ( points[1][0] - points[0][0] ) / ( points[1][1] - points[0][1] ) ;
        long sinAngle02 =  ( points[2][0] - points[0][0] ) / ( points[2][1] - points[0][1] ) ;
        return sinAngle01 != sinAngle02 ;    
    }
}
