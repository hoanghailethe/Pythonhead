import java.util.ArrayList;
import java.util.List;

public class _1642_furthestYouCanReach {

//     Wrong Answer
// Runtime: 0 ms
// Your input
// [4,2,7,6,9,14,12]
// 5
// 1
// Output
// 7
// Expected
// 4
    public int furthestBuilding(int[] heights, int bricks, int ladders) {
        int lowerBuilding = 0 ;
        List<Integer> distanceUp = new ArrayList<>();
        int preBuildingHeight = 99999;
        
        for (int height : heights) {
            if (preBuildingHeight >= height) lowerBuilding += 1;
            else {
                distanceUp.add( height - preBuildingHeight ); 
            }

            preBuildingHeight = height ;
        }

        int countClimb = 0 ; 

        while ( distanceUp.isEmpty() == false && (ladders > 0 || distanceUp.get(0) < bricks ) ) {
            int distance = distanceUp.remove(0);

            if (distance >= bricks ) bricks -= distance ;
            else ladders -= 1; 

            countClimb += 1;

        }

        return lowerBuilding + countClimb ;
    }

    //new Case
    Input
    [1,5,1,2,3,4,10000]
    4
    1
    Output
    3
    Expected
    5
    public int furthestBuilding2(int[] heights, int bricks, int ladders) { 
        int countBuildingClimbed = 0 ; 
        int preBuildingHeight = heights[0] ; 
        for (int i = 1 ; i < heights.length  ; i ++ ) {
            // System.out.println( i );
            // System.out.println( ladders > 0 || bricks > 0 );
            // System.out.println( bricks > 0 && heights[i] - preBuildingHeight >= bricks );

            if (heights[i] <= preBuildingHeight ) {
                countBuildingClimbed ++ ; 
            } else if (bricks > 0 && heights[i] - preBuildingHeight <= bricks ) {
                bricks -= (heights[i] - preBuildingHeight) ; 
                // System.out.println( bricks );
                countBuildingClimbed ++ ;
            } else if (ladders > 0) {
                ladders-- ;
                countBuildingClimbed ++ ;
            }
            else if (ladders == 0 && bricks == 0 && preBuildingHeight < heights[i]) break;
            else  countBuildingClimbed ++ ;

            preBuildingHeight = heights[i];
            
        }
        return countBuildingClimbed;
    }
}
