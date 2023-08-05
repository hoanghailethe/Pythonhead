class Solution {
    public boolean checkPerfectNumber(int num) {
        if(num == 1 ) return false ; 
        Set<Integer> dividors = new HashSet<>() ;
        dividors.add( 1) ; 

        for(int i = 2 ; i <=  num /2 ; i++ ) {
            if(num % i == 0 ) {
                dividors.add(i) ; 
                dividors.add(num / i ) ;
                
                } 
        }

        int sum = 0 ;
        for(int i : dividors ) {
            sum += i ;
        }
        
        return sum == num ;
    }
//     Runtime
// Details
// 2080ms
// Beats 10.31%of users with Java
// Memory
// Details
// 39.58mb
// Beats 27.68%of users with Java
}