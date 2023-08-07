class Solution {
    public String addStrings(String num1, String num2) {
        int remain = 0 ;
        StringBuilder sb = new StringBuilder() ;

        for (int i = num1.length() - 1 , j = num2.length() - 1 ; i >=0 || j >= 0 || remain > 0 ; i-- , j-- ) {
            int turn = 0 ; 

            if( i>= 0 ) turn += num1.charAt(i) - '0' ;
            System.out.println(turn ) ;
            if( j>= 0 ) turn += num2.charAt(j) - '0' ;
            System.out.println(turn ) ;

            if( remain > 0 ) {
                turn += remain ;
                remain = 0 ;
                }

            if (turn >= 10 ) {
                remain = turn / 10 ;
                turn -= remain *10 ;
            }
            System.out.println(turn ) ;

            sb.insert(0, turn) ;

        }
        return sb.toString() ;
    }
// Runtime
// Details
// 4ms
// Beats 44.03%of users with Java
// Memory
// Details
// 43.34mb
// Beats 47.83%of users with Java

public String addStrings(String num1, String num2) {

        int i = num1.length()-1;
        int j = num2.length()-1;
        int carry = 0;
        StringBuilder sb = new StringBuilder();

        while(i>=0 || j>=0){
           int sum = carry;

           if(i>=0) sum += num1.charAt(i--) - '0';
           if(j>=0) sum += num2.charAt(j--) - '0';

           sb.append(sum%10);
           carry = sum/10;
        }
        if(carry != 0)
          sb.append(carry);

        return sb.reverse().toString();  
    }
}