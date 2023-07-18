public class 234PandadromeLinkedList {
// Runtime
// Details
// 20ms
// Beats 17.22%of users with Java
// Memory
// Details
// 64.91mb
// Beats 5.53%of users with Java
    public boolean isPalindrome(ListNode head) {

        StringBuilder sb= new StringBuilder() ;

        for (ListNode node = head ; node!= null; node = node.next){
            if(node!= null) sb.append(node.val) ;

        }

        return sb.toString().equals( sb.reverse().toString() ); 
    }
     
}
