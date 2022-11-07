import java.util.ArrayList;
import java.util.LinkedList;
import java.util.stream.Collectors;

class _3110_testStreamCollect {
    public static void main(String[] args) {
        ArrayList<Integer> b = new ArrayList<>() ;
            b.add(1);
            b.add(2);
            
            b =  (ArrayList<Integer>) b.stream().filter( a -> a < 2).collect(Collectors.toList());  
            b.forEach(System.out::println);  
    }
}
