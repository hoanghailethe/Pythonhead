public class 867_transposeMatris {
    public int[][] transpose(int[][] matrix) {

        int rSize= matrix.length ; 
        int cSize = matrix[0].length ;

        // int[][] flipMatriz = new int[rSize][cSize] ;
        int[][] flipMatriz = new int[cSize][rSize] ;
        
        for(int r = 0 ; r < matrix.length ; r++ ) {
            for(int c = 0 ; c < matrix[0].length; c++) {
                flipMatriz[c][r]=matrix[r][c];
            }
        }

        return flipMatriz;
    }
//     Runtime
// Details
// 1ms
// Beats 29.49%of users with Java
// Memory
// Details
// 44.52MB
// Beats 33.78%of users with Java
}
