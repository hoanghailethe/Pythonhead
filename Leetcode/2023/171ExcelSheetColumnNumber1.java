public class excelSheetColumnNumber171 {

    // int[] charArr = new int[200] ;
//     Runtime
// Details
// 1ms
// Beats 100.00%of users with Java
// Memory
// Details
// 41.27mb
// Beats 71.29%of users with Java
    public int titleToNumber(String columnTitle) {

        // int nPower = columnTitle.length ;

        int res = 0 ;

        for(int i = 0 ; i < columnTitle.length() ; i++) {
            int thuTuTrongHe26 = (int) (columnTitle.charAt(i) - 'A' + 1 ) ;
            res = res + (int)(thuTuTrongHe26 * Math.pow( 26, columnTitle.length() - 1 - i )) ;
        }
        return res ;

        
    }
}
