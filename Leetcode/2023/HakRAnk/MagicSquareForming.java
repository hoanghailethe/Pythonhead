import java.util.List;

public class MagicSquareForming {
    static int [][][] MAGIC_SQUARES = {
        {{8, 1, 6},{3, 5, 7},{4, 9, 2}},
        {{6, 1, 8},{7, 5, 3},{2, 9, 4}},
        {{4, 9, 2},{3, 5, 7},{8, 1, 6}},
        {{2, 9, 4},{7, 5, 3},{6, 1, 8}},
        {{8, 3, 4},{1, 5, 9},{6, 7, 2}},
        {{4, 3, 8},{9, 5, 1},{2, 7, 6}},
        {{6, 7, 2},{1, 5, 9},{8, 3, 4}},
        {{2, 7, 6},{9, 5, 1},{4, 3, 8}}
    };
    

    public static int formingMagicSquare(List<List<Integer>> s) {
    // Write your code here
        int cost = 100000;
        for(int[][] solution : MAGIC_SQUARES ) {
            cost = Math.min(cost, calculateCost (solution , s ) ) ;
        }
        return cost ;
        

    }

    public static int calculateCost(int[][] solution , List<List<Integer>> s) {
        int cost = 0 ; 
        for( int i = 0 ; i < s.size() ; i++ ) {
            for(int j = 0 ; j < 3 ; j++){
                cost += Math.abs( solution[i][j] - s.get(i).get(j) ) ;
            }
        }
        return cost ;
    }
}
