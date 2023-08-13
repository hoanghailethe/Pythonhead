public class 36ValidSudoku {
    public boolean isValidSudoku(char[][] board) {
        return checkRow (board)&& checkCol(board) &&checkBlock(board) ;
    }

    public  boolean checkRow(char[][]b){
        for(char[]r: b) {
            int[]chk=new int[128] ;

            for(char c: r) {
                if(c=='.')continue;
                if(chk[c]!=0) return false ;
                chk[c]++;
            }
        }
        return true ;
    }
    public  boolean checkCol  (char[][]b){
        int col = 0 ;
        while(col<9)  {
            int[]chk=new int[128] ;
            for(char[]r: b) {
                char c = r[col] ;
                if(c=='.')continue;
                if(chk[c]!=0) return false ;
                chk[c]++;
            }
            col++;
        }
        return true ;


        
    }
    public  boolean checkBlock(char[][]b){

        int sR= 0  ; // startRow Index
        
        // int BLOCK_LENGTH = 3 ; //block n* n

        for(int sR = 0 ; sR < 3;sR++) {
            for(int sC = 0 ; sC < 3;sC++) {
                int[]chk=new int[128] ;

                for(int i = 0 ; i < 3  ;  i++)  {
                    for(int j = 0 ; j<3 &&sR+i< 3; j++ ) {
                        char c = b[sR+i][sC+j] ;
                        if(c=='.')continue;
                        if(chk[c]!=0) {
                            System.out.println(sR+i+ "  "  + sC+j);
                            return false ;
                        }
                        chk[c]++;
                    }
                }
            }

        }
        return true ;
    }

    public  boolean checkBlock(char[][]b){
        for(int block = 0 ; block < 9 ; block++) {
            int[]chk=new int[128] ;
        
            for(int i = block ; i <= block+3  ;  i++)  {
                for(int j = block ; j<block+3; j++ ) {
                    char c= b[i%3][j%3];
                    if(c=='.')continue;
                    System.out.print(i + " " +  j) ;
                    if(chk[c]!=0) return false ;
                    chk[c]++;
                    
                }
            }
        }

        return true ;
    }

// [["5","3",".",".","7",".",".",".","."]
// ,["6",".",".","1","9","5",".",".","."]
// ,[".","9","8",".",".",".",".","6","."]
// ,["8",".",".",".","6",".",".",".","3"]
// ,["4",".",".","8",".","3",".",".","1"]
// ,["7",".",".",".","2",".",".",".","6"]
// ,[".","6",".",".",".",".","2","8","."]
// ,[".",".",".","4","1","9",".",".","5"]
// ,[".",".",".",".","8",".",".","7","9"]]
// R: 
//  00 01 02  3 4 5 6 7
//  10 11 12 
//  20 21 22 
//  3
//  4
 
// r: 0-9 % 3
//   0 1 2 3 4 5 6 7 8
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8

    public  boolean checkBlock3(char[][]b){
        for(int colR = 0 ; colR < 9 / b.length  ; colR++) {
            for( int i = 0 ; i < 3 ; i ++ ) {
                for(int rowR = 0 ; rowR < 9 / b.length  ; rowR++) {
                    for( int j = 0 ; j< 3 ; j++ ) {
                        int[]chk=new int[128] ;
                        int colI = colR  + i ;
                        int rowI = rowR + j ;

                        char c= b[colI][rowI];
                        
                        System.out.print(colI + " " +  rowI) ;
                        if(c=='.')continue;
                        if(chk[c]!=0) return false ;
                        chk[c]++;


                    }
                }

            }
        }
        
        return true ;
    }

    public  boolean checkBlock(char[][]b){
        int BLOCK_LENGTH = 3 ;

        for(int i = 0 ; i < 9  ; i+= b[0].length/ BLOCK_LENGTH ) {
            for( int j = 0 ; j < 9  ; j += b.length/ BLOCK_LENGTH ) {
                int[]chk=new int[128] ;
                for(int r = i ; r < i+ 3   ; r++) {
                    for( int c = j ; c< j+3 ; c++ ) {
                        
                        

                        char ch = b[r][c];
                        
                        // System.out.println(c + " " +  r) ;
                        if(ch=='.')continue;
                        if(chk[ch]!=0) {
                            // System.out.println("FAIL " + colI + " " +  rowI) ;
                            return false ;
                            }
                        chk[ch]++;
                    }
                }
            }
        }
        
        return true ;
    
    }
//     Runtime
// Details
// 2ms
// Beats 84.30%of users with Java
// Memory
// Details
// 43.79mb
// Beats 37.07%of users with Java

// [
// [".",".",".",".","5",".",".","1","."],
// [".","4",".","3",".",".",".",".","."],
// [".",".",".",".",".","3",".",".","1"],
// ["8",".",".",".",".",".",".","2","."],
// [".",".","2",".","7",".",".",".","."],
// [".","1","5",".",".",".",".",".","."],
// [".",".",".",".",".","2",".",".","."],
// [".","2",".","9",".",".",".",".","."],
// [".",".","4",".",".",".",".",".","."]]}


public boolean isValidSudoku(char[][] board) {
    Set seen = new HashSet();
    for (int i=0; i<9; ++i) {
        for (int j=0; j<9; ++j) {
            char number = board[i][j];
            if (number != '.')
                if (!seen.add(number + " in row " + i) ||
                    !seen.add(number + " in column " + j) ||
                    !seen.add(number + " in block " + i/3 + "-" + j/3))
                    return false;
        }
    }
    return true;
}

 

// others
class Solution {
    public boolean isValidSudoku(char[][] board) {
        for (int row = 0; row < 9; row++) {
            for (int column = 0; column < 9; column++) {
                if (board[row][column] != '.' && !isValidPlacement(board, board[row][column], row, column))
                    return false;
            }
        }
        return true;
    }

    private boolean isNumberInRow(char[][] board, char number, int row, int column) {
        for (int i = 0; i < 9; i++) {
            if (column != i && board[row][i] == number) return true;
        }
        return false;
    }

    private boolean isNumberInColumn(char[][] board, char number, int row, int column) {
        for (int i = 0; i < 9; i++) {
            if (row != i && board[i][column] == number) return true;
        }
        return false;
    }

    private boolean isNumberInBox(char[][] board, char number, int row, int column) {
        int boxRow = row - row % 3;
        int boxColumn = column - column % 3;
        for (int i = boxRow; i < boxRow + 3; i++) {
            for (int j = boxColumn; j < boxColumn + 3; j++) {
                if (row != i && column != j && board[i][j] == number) return true;
            }
        }
        return false;
    }

    private boolean isValidPlacement(char[][] board, char number, int row, int column) {
        return !isNumberInRow(board, number, row, column) &&
                !isNumberInColumn(board, number, row, column) &&
                !isNumberInBox(board, number, row, column);
    }
}
