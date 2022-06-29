import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;


// Runtime: 4 ms, faster than 12.42% of Java online submissions for Last Stone Weight.
// Memory Usage: 41.8 MB, less than 30.64% of Java online submissions for Last Stone Weight.

public class _1046_lastStoneWeight {
    public int lastStoneWeight(int[] stones) {
        // int res = 0 ; 
        ArrayList<Integer> orderedStone = new ArrayList<>();
        for(int stone : stones ) {
            orderedStone.add(stone);
        }
        Collections.sort(orderedStone, Collections.reverseOrder()) ;

        if(orderedStone.size() == 0) {
            return 0 ;
        }
        // System.out.println(orderedStone);

        while ( orderedStone.size() > 1 ) {
            int first = orderedStone.remove(0) ;
            int second = orderedStone.remove(0);

            int dif = Math.abs(first - second) ;
            insertStoneInOrderBinaSearch (dif, orderedStone);
        }

        return orderedStone.get(0);
    }

    private void insertStoneInOrderBinaSearch(int res, ArrayList<Integer> orderedStone) {
        if (orderedStone.size() == 0) {
            orderedStone.add(res );
            return ;
        }
        System.out.println("BEFORE " + orderedStone);
        int begin = 0 ; 
        int end = orderedStone.size() - 1 ;

        //find where to put res inorder  :  pre <= res <= after
        if (  res >= orderedStone.get(begin) ) orderedStone.add(0, res);
        else if (res <= orderedStone.get(end) ) orderedStone.add(res) ;
        else {
            int mid = begin; 

            while( ! (orderedStone.get(mid) >= res && res >= orderedStone.get(mid+1) ) ){
                
                mid = (begin + end ) / 2 ;

                if( orderedStone.get(mid) >= res ) begin = mid ;
                else if(orderedStone.get(mid) <=  res) end =mid ;
            }

            orderedStone.add(mid+1, res);

        }
        System.out.println("AFTER " + orderedStone);

    }
}
