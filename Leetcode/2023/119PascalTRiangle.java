public class 119PascalTRiangle {
//     Runtime
// 0 ms
// Beats
// 100%
// Memory
// 39.7 MB
// Beats
// 99.72%
    public List<Integer> getRow(int rowIndex) {
     
        ArrayList<Integer> res = new ArrayList<>() ;

        int[] row = new int[rowIndex + 1] ; 
        row[0] = 1 ;

        for(int i = 0 ; i < rowIndex+1  ; i++ ) {
            
            row[i] = 1 ;
            for(int j = i - 1 ; j > 0 ; j-- ) {
                row[j] = row[j] + row[j-1] ;
            }
        }

        for(int i = 0; i < row.length ; i ++) {
            res.add(row[i]) ;
        }
        // System.out.println(res) ;
        return res ;
    }
}
