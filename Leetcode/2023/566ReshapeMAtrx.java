class Solution {
    public int[][] matrixReshape(int[][] mat, int r, int c) {
        int matRow = mat.length ;
        int matCol = mat[0].length ;

        if(matCol*matRow != r*c ) return mat ;
        
        int[][] newMat = new int[r] [c] ;
        for(int i = 0 ; i < matCol*matRow ; i++ )  {
            newMat[i/c][i%c]  = mat [i/matCol][i%matCol] ;
        }   

        return newMat ; 
    }
}


Runtime
Details
0ms
Beats 100.00%of users with Java
Memory
Details
44.51MB
Beats 34.85%of users with Java

