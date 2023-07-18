class Solution {

    public boolean canWinNim(int n) {
        boolean canWin = true ;
        for(int i = 3; i <=n; )  {
            if(canWin) i+= 1;
            else i+=2 ;
            canWin = !canWin ;
        }
        return canWin ;

    }

//n = 1348820612    STACK OVER
}