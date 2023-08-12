import java.util.Set;

class Solution {
    Set<String> addressAndValue = new HashSet() ; 
    public void solveSudoku(char[][] board) {
        for(int row = 0 ; row < board.length ; row++ ) {
            for (int col = 0 ; col < board[0].length ; col++ ) {
                char ch =  board[row][col]; 
                if (  ch != '.') {
                    addressAndValue.add("row address " + row + " has value : " + ch);
                    addressAndValue.add("col address " + col + " has value : " + ch);
                    addressAndValue.add("block address " +  row/3  + " " + col/ 3  + " has value : " + ch);
                }
            }
        }
        solveByBackTrack(board, 0 , 0 ) ; 
    }

    public void solveByBackTrack(char[][] board, int row, int col ) {
        if ( row >= 9 || col >= 9 )return ;
        if(board[row][col] == '.') {
            for(char num = '1' ; num <= '9' ; num++ ) {
                board[row][col] = num ; 
                if( isCellValid(row,col,num)) {
                    addValue(row,col,num) ;
                    if(isSolvable ( board , row, col )) {
                        return;
                    }else {
                        removeValue(row, col, num);
                    }
                } 
                board[row][col] = '.' ; 

            }
            
                    
        } else if(col==8) { //move to next
            solveByBackTrack(board, row+1, 0);
        } else {
            solveByBackTrack(board, row, col+1);
        }

    }


    public boolean isCellValid (int row, int col, char ch ) {
        return !addressAndValue.contains("row address " + row + " has value : " + ch) 
                &&!addressAndValue.contains("col address " + col + " has value : " + ch) 
                &&!addressAndValue.contains("block address " +  row/3  + " " + col/ 3  + " has value : " + ch);
    }

    public boolean isSolvable (char[][] board, int row, int col ) {
        solveByBackTrack(board, row , col ) ;
        for(char[] r: board ) {
            for(char cell : r ) {
                if (cell == '.') return false ;
            }
        }
        return true;
    }

    public void addValue (int row, int col, char ch) {
        addressAndValue.add("row address " + row + " has value : " + ch);
        addressAndValue.add("col address " + col + " has value : " + ch);
        addressAndValue.add("block address " +  row/3  + " " + col/ 3  + " has value : " + ch);

    }

    public void removeValue (int row, int col, char ch) {
        addressAndValue.remove("row address " + row + " has value : " + ch);
        addressAndValue.remove("col address " + col + " has value : " + ch);
        addressAndValue.remove("block address " +  row/3  + " " + col/ 3  + " has value : " + ch);
    }

//     Runtime
// Details
// 103ms
// Beats 10.02%of users with Java
// Memory
// Details
// 44.07mb
// Beats 5.48%of users with Java

}