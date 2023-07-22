import java.util.ArrayList;

class Solution {
    static int[][] changeKnightMoves = {{-1, -2},{-2, -1 },{-2, 1},{-1,2},{2,1},{1,2},{2,-1},{1,-2} } ; // row then col change
    static double movePosibleNumber =0;
    static double moveRemainOnBoard =-1; // Bù vị trí START

    public double knightProbability(int n, int k, int row, int column) {

        int[] currentPos = {row, column};

        nextMOvePosible(currentPos,  k , n);

        System.out.println("FINAL :"+movePosibleNumber + " " + moveRemainOnBoard) ;
        if(movePosibleNumber>0)return moveRemainOnBoard/ movePosibleNumber ;
        else return 0L;
    }

    void nextMOvePosible(int[] currentPos,  int turnToMove ,int boardSize) {
        if(currentPos[0] < 0 ||currentPos[0] >boardSize-1|| currentPos[1] < 0 ||currentPos[1] >boardSize-1) return; // invalid
        moveRemainOnBoard+=1 ;
         System.out.println(currentPos[0] + " " + currentPos[1]) ;

        if (turnToMove == 0) return; // No turn left
        movePosibleNumber += 8 ; //next move possible 

        for(int[]move : changeKnightMoves) {
            int[]nextPos = { currentPos[0] + move[0] , currentPos[1] + move[1]};
            nextMOvePosible(nextPos, turnToMove-1, boardSize);
        }

    }
}