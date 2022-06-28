import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

public class _1046_lastStoneWeight {
    public int lastStoneWeight(int[] stones) {
        int res = 0 ; 
        Arrays.sort(stones, Collections.reverseOrder());
        ArrayList<Integer> orderedStone = new ArrayList<>(Arrays.asList(stones));
        insertStoneInOrder ( res , orderedStone );
        
        
        int preStone = -1 ; 

        for (int stone : orderedStone) {
            if ( orderedStone.size() == 1) break ;
            
            if () preStone = orderedStone.remove(0);
            
            res  = Math.abs(preStone - stone) ;
            insertStoneInOrder ( res , orderedStone );
        }

        return res;
    }

    private void insertStoneInOrder(int res, ArrayList<Integer> orderedStone) {

    }
}
