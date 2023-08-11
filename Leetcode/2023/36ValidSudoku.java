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

}
