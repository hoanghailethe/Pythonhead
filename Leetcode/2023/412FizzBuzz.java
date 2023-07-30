class Solution {
    Runtime
Details
1ms
Beats 99.56%of users with Java
Memory
Details
44.58mb
Beats 82.54%of users with Java

    public List<String> fizzBuzz(int n) {
        
        // StringBuilder sb = new StringBuilder() ;

        List<String> res = new ArrayList() ;
        for(int i = 1 ; i <= n ; i++ ) {
            if(i%3 == 0 && i %5 == 0) res.add("FizzBuzz") ;
            else if(i%3 == 0) res.add("Fizz");
            else if(i%5 == 0) res.add("Buzz") ;
            else res.add(i+"");
        }
        return res ;
    }
}