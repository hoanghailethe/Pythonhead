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
class Solution {
//     Runtime
// 1 ms
// Beats
// 80.53%
// Memory
// 44.3 MB
// Beats
// 81.18%
    public ListNode removeElements(ListNode head, int val) {
        if(head == null) return null ;
        if(head != null  ) {
            if(head.val ==val) {
                // head = head.next ;
                head =removeElements(head.next, val) ; 
            } else {
                head.next = removeElements(head.next, val) ;
            }
            
        } 
        
        return head ;
        
    }
}