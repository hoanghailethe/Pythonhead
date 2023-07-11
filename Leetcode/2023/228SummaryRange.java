public class 228SummaryRange {
//     Runtime 6 ms
// Beats
// 36.36%
// Memory
// 41 MB
// Beats
// 48.16%

    public List<String> summaryRanges(int[] nums) {
        List<String> res = new ArrayList<>() ;


        Integer from =null ; 
        Integer to =null;

        for(int num : nums ) {
            if(from == null ) {
                from = num ; to = num ;
            } else if (num == to + 1) {
                to = num ;
            } else if(num > to+1 && from< to) {
                res.add(from+"->"+to);
                from = num ; to = num ;
            } else { // from == to 
                res.add(from+"");
                from = num ; to = num ;
            }
        }
        if(from != null && to != null ) {
            if(from < to) {
                res.add(from+"->"+to);  
            } else {
                res.add(from+"") ;
            }
            
        }

        return res ;
    }

    //[-2147483648,-2147483647,2147483647]
    //[-1000000000,-9999,0,1,2,10,100,1000,999999999,1000000000]
}
