public class 50RelativeRank {
    public String[] findRelativeRanks(int[] score) {
        int[] rankPosition = new int[score.length] ;

        // Integer[] scoreCopy = Arrays.copyOf(score, score.length);
        Integer[] scoreCopy = new Integer[score.length] ;
        for(int i= 0; i < score.length ;i++) {
            scoreCopy[i]=score[i] ;
        }
        Arrays.sort(scoreCopy, Collections.reverseOrder());
        Map<Integer, String> scorePosition=new HashMap();

        for(int i= 0; i < scoreCopy.length ;i++) {
            if(i==0)scorePosition.put(scoreCopy[i], "Gold Medal") ;
            else if(i==1)scorePosition.put(scoreCopy[i], "Silver Medal") ;
            else if(i==2)scorePosition.put(scoreCopy[i], "Bronze Medal") ;
            else scorePosition.put(scoreCopy[i], i+1+"") ;
        }
        String[] res = new String[score.length  ];
        for(int i= 0; i < score.length ;i++) {
            res[i]= scorePosition.get(score[i]) ;
        }
        return res;
    }
//     Runtime
// Details
// 12ms
// Beats 28.74%of users with Java
// Memory
// Details
// 45.16mb
// Beats 23.12%of users with Java
}
