public class 2806AccountBalance {
    public int accountBalanceAfterPurchase(int purchaseAmount) {
        int roundPurchase ;

        if(purchaseAmount % 10 >= 5 ) {
            roundPurchase = purchaseAmount/10+1 ;
        }else {
            roundPurchase = purchaseAmount/10 ;
        }
        return 100 - roundPurchase*10;
    }
//     Runtime
// Details
// 0ms
// Beats 100.00%of users with Java
// Memory
// Details
// 39.24MB
// Beats 53.21%of users 
}
