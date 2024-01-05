import java.lang.reflect.Array;
import java.util.Arrays;

public class Bulbs_interview {
    
    public static int countAllLightOn(int[] bulbs) {
    
        // Map<Integer> map = new HashMap<>() ;
        Set<Integer> set = new HashSet() ;
        List <Integer> bulbsList = Arrays.asList(bulbs) ;
        
        int count = 0;
        IntStream().range( 0, bulbsList.size() )
            .forEach(
                i -> {
                    int bulbRank = bulbsList.get(i) ;
                    set.add(bulbRank) ;

                    boolean allBulbIsOn = true ;
                    while (bulbRank > 0) {
                        if(set.contains(--bulbRank)) {
                            allBulbIsOn =false ;
                            break ;
                        }
                        // bulbRank--;
                    }
                    if (allBulbIsOn) count++ ;
                }
            );

        return count;
    }
    public static void main(String[] args) {
        int[] bulbs = new int[] {2,1,3,5,4} ;
        System.print.out( countAllLightOn(bulbs) ) ;        
    }


}

public class LightBulbExercise {

    public static int countAllLightOn(int[] bulbs) {
        Set<Integer> set = new HashSet<>(bulbs.length);

        int count = 0;
        IntStream.range(0, bulbs.length)
            .forEach(i -> {
                int bulbRank = bulbs[i];
                set.add(bulbRank);

                boolean allBulbIsOn = true;
                while (bulbRank > 0) {
                    if (set.contains(--bulbRank)) {
                        allBulbIsOn = false;
                        break;
                    }
                }
                if (allBulbIsOn) count++;
            });

        return count;
    }

    public static void main(String[] args) {
        int[] bulbs = {4, 3, 2, 5, 1};
        System.out.println(countAllLightOn(bulbs)); // Output: 3
    }
}