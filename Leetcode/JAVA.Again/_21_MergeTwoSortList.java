public class _21_MergeTwoSortList {
    public ListNode mergeTwoLists(ListNode list1, ListNode list2) {
        if (list1 == null) return list2;
        if (list2 == null) return list1;
        
        ListNode nNode ;
        if (list1.val < list2.val) nNode = new ListNode(list1.val) ;
        else nNode = new ListNode (list2.val) ;
        
        ListNode runner = null ;
        nNode.next = runner ;
        while ( list1 != null && list2 != null ) {
            if (list1 == null){
                runner = list2; break;
            }
            if ( list2 == null) {
                runner = list1; break;
            }
            if (list1.val < list2.val ) {
                runner = new ListNode(list1.val);
                list1 = list1.next ;
            } else {
                runner = new ListNode(list2.val);
                list2 = list2.next ;
            }
            runner = runner.next; 
        }
        
        return nNode ; 
    }

    public ListNode mergeTwoLists2(ListNode list1, ListNode list2) {
        if(list1 == null){
            return list2;
        }
         if(list2==null){
             return list1;
         }
         if(list1.val<list2.val){
             list1.next = mergeTwoLists(list1.next , list2);
             return list1;
         }
         else{
             list2.next = mergeTwoLists(list2.next , list1);
         }
           return list2;
       }
}
