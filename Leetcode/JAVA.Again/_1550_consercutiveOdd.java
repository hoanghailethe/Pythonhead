public class _1550_consercutiveOdd {
//     Runtime: 0 ms, faster than 100.00% of Java online submissions for Three Consecutive Odds.
// Memory Usage: 42.4 MB, less than 71.60% of Java online submissions for Three Consecutive Odds.
    public boolean threeConsecutiveOdds(int[] arr) {
        int count = 0 ;
        for (int num : arr) {
            if( num % 2 ==0) count = 0;
            else count ++;

            if ( count == 3 ) return true ; 
        }
        return false ;
    }
}
