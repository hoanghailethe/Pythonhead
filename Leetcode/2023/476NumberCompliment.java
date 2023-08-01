class Solution {
    1ms
Beats 19.67%of users with Java
Memory
Details
39.10mb
Beats 91.82%of users with Java
    public int findComplement(int num) {
         Stack<Integer> st = new Stack<>() ;

        while(num > 0 ) {
            if(num%2==1) st.push(0) ;
            else st.push(1);
            num /= 2 ;
        }
        // int fac =0 ;
        int res = 0  ;
        // if(st.isEmpty() == false)res = st.pop() ;

        while(st.isEmpty() == false  ) {
            res = 2* res  + st.pop() ;
        }
        return res ;
        
    }


    public int findComplement(int num) {
        Queue<Integer> queue = new LinkedList<>() ;

        while(num >=1 ) {
            if(num%2==1) queue.add(0) ;
            else queue.add(1);
            num /= 2 ;
        }
        // int fac =0 ;
        int res = 0  ;
        if(queue.isEmpty() == false)res = queue.poll() ;

        while(queue.isEmpty() == false  ) {
            res = 2* (res  + queue.poll()) ;
        }
        return res ;
    }
}