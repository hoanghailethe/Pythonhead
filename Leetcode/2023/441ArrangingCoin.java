public class 441ArrangingCoin {
    
    public int arrangeCoins(int n) {
        return arrangeCoinLevel(n, 0 ) ; 
    }

    public int arrangeCoinLevel(int n, int level){
        if(n -level > 0 ) return arrangeCoinLevel(n - level, level + 1);
        else if(n-level == 0) return level ;
        else return level - 1;
    }
}
