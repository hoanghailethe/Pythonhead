class Solution {
    Set addressAndValue = new HashSet() ; 
    public void solveSudoku(char[][] board) {
    
        for(int row = 0 ; row < board.length ; row++ ) {
            for (int col = 0 ; col < board[0].length ; col++ ) {
                char ch =  board[row][col]; 
                if (  ch != '.') {
                    addressAndValue.add("row address " + row + " has value : " + ch);
                    addressAndValue.add("col address " + col + " has value : " + ch);
                    addressAndValue.add("block address " + row/3 +" " col/ 3+ " has value : " + ch);
                }
                
                    
            
            }
        }

        solveByBackTrack(board, 0 , 0 ) ; 
    }

    public void solveByBackTrack(char[][] board, int row, int col ) {
        if ( row >= 9 || col >= 9 )return 
        if(board[row][col] == '.') {
            for(int num = 1 ; num <= 9 ; num++ ) {
                board[row][col] = num ; 
                if( isValid(row,col,num) && isSolvable ( board , row, col )) return ;
                board[row][col] = '.' ; 

            }
            
                    
        } else if(col==8) { //move to next
            solveByBackTrack(board, row+1, 0);
        } else {
            solveByBackTrack(board, row, col+1);
        }

    }


    public boolean isSolvable (int row, int col, int num ) {

    }

    public boolean isSolvable (char[][] board, int row, int col, int val ) {

    }

}