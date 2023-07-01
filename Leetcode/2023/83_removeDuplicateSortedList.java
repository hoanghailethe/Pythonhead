public class 83_removeDuplicateSortedList {
//     Runtime
// 0 ms
// Beats
// 100%
// Memory
// 43.2 MB
// Beats
// 47.97%
    public ListNode deleteDuplicates(ListNode head) {
        
        if(head!=null && head.next!= null ) {

            while(head.next!= null && head.val == head.next.val) head.next = head.next.next ;
            deleteDuplicates(head.next) ;
        
        } ;

        return head ;
    }
}
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */