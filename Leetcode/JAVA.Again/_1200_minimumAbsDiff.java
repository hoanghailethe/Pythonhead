import java.util.ArrayList;
import java.util.List;

public class _1200_minimumAbsDiff {
    // time limit access
    public List<List<Integer>> minimumAbsDifference(int[] arr) {

        List<List<Integer>> res = new ArrayList<>(); 
        int dif = Integer.MAX_VALUE; 

        for(int x = 0 ; x < arr.length ; x++){

            int a = arr[x] ;
            for (int y = x + 1 ; y < arr.length ; y++ ) {
                int b  = arr[y] ;
                if (dif > Math. abs ( a - b )) res.clear();

                if (dif >= Math. abs ( a - b ) ) {
                    dif = Math. abs ( a - b ) ; 
                    List<Integer>elements = new ArrayList<>() ;
                    if( a < b  ) {
                        elements.add(a) ;
                        elements.add(b);
                    } else {
                        elements.add(b) ;
                        elements.add(a);
                    } 
                    res.add(elements); 
                    continue ; 
                } 
 
            }
        }
        res.sort((o1, o2 ) -> o1.get(0).compareTo(o2.get(0)));
        return res ;
    }
}
