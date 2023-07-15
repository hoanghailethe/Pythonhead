public class REverseLinkedList206 {
    public ListNode reverseList(ListNode head) {
        Stack<Integer> stack = new Stack<>() ;
        
        ListNode headRes = head ;

        while(headRes != null) {
            // System.out.println(stack) ;
            System.out.println(headRes.val) ; 
            stack.push(headRes.val) ;
            headRes = headRes.next;
        }

        if(stack.isEmpty() == false)headRes = new ListNode(stack.pop()) ;
        ListNode tailRun = headRes ;

        while( stack.isEmpty() == false  ) {
            tailRun.next = new ListNode(stack.pop()) ;
            tailRun = tailRun.next ;
        }

        return headRes;
    }    
}

Runtime
Details
2ms
Beats 100.00%of users with Java
Memory
Details
42.26mb
Beats 6.47%of users with Java