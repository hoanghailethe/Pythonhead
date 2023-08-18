class Solution {

    HashMap <Integer, Integer> cache = new HashMap() ;
    public int minCostClimbingStairs(int[] cost) {
        return minCostToStep(  cost.length  , cost ) ;
    }

    public int minCostToStep( int n , int[] cost ) {
        if(cache.keySet().contains(n)) return cache.get(n);
        if(n<=1) return 0 ;
        int res =  Math.min(minCostToStep(n-2, cost) + cost[n-2] , minCostToStep(n-1, cost) + cost[n-1 ]) ;

        //save cache 
        cache.put(n, res ) ;

        return res ;
    }
//     Time Limit Exceeded
// 259 / 283 testcases passed
// Last Executed Input
// Use Testcase

// Runtime
// Details
// 3ms
// Beats 8.25%of users with Java
// Memory
// Details
// 43.16MB
// Beats 45.72%of users with Java


}