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
}
