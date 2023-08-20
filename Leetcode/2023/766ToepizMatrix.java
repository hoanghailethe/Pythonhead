public class 766ToepizMatrix {
    public boolean isToeplitzMatrix(int[][] matrix) {
        int maxR = matrix.length - 1 ;
        int maxC = matrix[0].length - 1;
        for(int r = 0 ; r <= maxR ; r++ ) {
            for (int c = 0; c <= maxC ; c++) {
                if( isValidToeplitCell(r, c, maxR, maxC,matrix) ==false )return false ;
            }
        }
        return true ;
    }

    public boolean isValidToeplitCell(int rowI, int colI, int maxR, int maxC,int[][] matrix){
        if(rowI==maxR || colI == maxC) return true ;
        return matrix[rowI][colI] ==  matrix[rowI+1][colI+1]
    }
//     Runtime
// Details
// 1ms
// Beats 56.15%of users with Java
// Memory
// Details
// 43.17MB
// Beats 63.01%of users with Java
}
