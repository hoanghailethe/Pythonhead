class Solution {

//     Runtime
// 2 ms
// Beats
// 93.52%
// Memory
// 61 MB
// Beats
// 63.78%
    public int maxProfit(int[] prices) {
        int profit = 0 ;

        int lowest  = Integer.MAX_VALUE ;
        int highest = 0 ;

        for(int price : prices) {
                        // System.out.print ( "h " + highest + " " + lowest ); 
            if(price < lowest) {
                
                profit = Math.max(profit, highest-lowest) ;
                lowest = price; 

                // RESET
                highest = 0 ;
            } else if (lowest != Integer.MAX_VALUE && price > highest) {
                highest = price;
            }

        }
        profit = Math.max(profit, highest-lowest) ;
        return profit ;
    }
}
