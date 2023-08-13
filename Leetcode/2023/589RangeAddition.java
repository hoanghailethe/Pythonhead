public class 589RangeAddition {
    
    public int maxCount(int m, int n, int[][] ops) {
        if(ops.length == 0) return m*n;
        // int beg = 0 ;
        int minRangeCol=Integer.MAX_VALUE ;
        int minRangeRow=Integer.MAX_VALUE ;

        for (int[]range : ops) {
            int r =  range[0] ;
            int c =  range[1]  ;

            if( r >=0 && c  >= 0) {
                // beg++;
                minRangeRow = Math.min(minRangeRow, r) ;
                minRangeCol = Math.min(minRangeCol, c) ;

            } 
        }
        return minRangeCol * minRangeRow; 
        
    }

    Runtime
Details
1ms
Beats 9.84%of users with Java
Memory
Details
44.93mb
Beats 21.28%of users with Java

}
