public class 575DistributeCandies {
    public int distributeCandies(int[] candyType) {
        int maxCandiesCanEat =candyType.length / 2 ;

        Set typeTicker= new HashSet () ;

        for(int candy :candyType) {
            if(typeTicker.contains(candy) == false ) {
                typeTicker.add(candy);
                maxCandiesCanEat-- ;

             }
             if (maxCandiesCanEat== 0)break ;
        }
        return typeTicker.size()  ;
    }
    Runtime
Details
21ms
Beats 95.05%of users with Java
Memory
Details
44.96mb
Beats 34.91%of users with Java
}
