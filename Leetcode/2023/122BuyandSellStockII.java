public class 122BuyandSellStockII {

    Runtime
1 ms
Beats
91.1%
Memory
44.6 MB
Beats
30.48%
    public int maxProfit(int[] prices) {
        int profit = 0 ;

        int lowest  = Integer.MAX_VALUE ;
        int highest = 0 ;
        // int prePrice = 0 ;

        //them diem chot loi nhuan va reset lai lowest

        for(int price : prices) {
            //  System.out.println ( "high " + highest + " lowe: " + lowest ); 
            

            // CHot loi nhuan va rest:
            if(highest > 0 && price < highest ) {
                if( highest> lowest) profit = profit + highest-lowest ;
                lowest = price; 
                // RESET
                highest = 0 ;
                
            } 
            else if ( price > highest&& lowest != Integer.MAX_VALUE  ) {
                highest = price;
            }
            if(price < lowest )lowest=price;

            

        }
        if(highest > lowest) profit += highest-lowest;
        return profit ;   
    }
}
