public class 168ExcelSheetColumnTitle {

//     Runtime
// 0 ms
// Beats
// 100%
// Memory
// 39.8 MB
// Beats
// 73.66%

    int ALPHABTE_NO = 26 ;
    public String convertToTitle(int columnNumber) {

        char[] table = new char[25] ;
        // table[0] = 'Z' ;

        for(int i = 0 ; i < table.length ; i++) {
            table[i] = (char) ('A' + i );
        }

        StringBuilder sb = new StringBuilder() ;

        while(columnNumber >= 1) {
            if(columnNumber % ALPHABTE_NO == 0) {
                sb.insert( 0 , 'Z'  ) ;
                columnNumber = columnNumber/  ALPHABTE_NO - 1;
            }
            else {
                sb.insert( 0 , table[ columnNumber %  ALPHABTE_NO  - 1 ] ) ;
                columnNumber /=   ALPHABTE_NO;
            }
        }

        return sb.toString() ;
        
    }
}
