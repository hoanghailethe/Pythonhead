/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
public class Solution {
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {

        String codeNodeA = "" ;
        String codeNodeB = "" ;

        ListNode run = null ;
        run = headA ;
        while(run != null )  {
            codeNodeA += run.val ;
            run =run.next ;
        }

        run = headB; 
        while(run != null ) {
            codeNodeB += run.val ;
            run = run.next ;
        }

        int longestCommon = 0 ;

        int sizeA = codeNodeA.length() ;
        int sizeB = codeNodeB.length() ;

        while (longestCommon < sizeA && longestCommon< sizeB && codeNodeA.charAt(sizeA - 1 - longestCommon ) == codeNodeB.charAt( sizeB - 1 - longestCommon) ) {
            longestCommon++ ;
        }
        if(longestCommon ==  0 ) return null ;

        ListNode res =null ;
        int idA =  sizeA - longestCommon ;
        int idB = sizeB  -longestCommon ;



        ListNode runA =headA;
        ListNode runB = headB; 

        for (int i = 1; i<= idA ; i++ ) {
            runA = runA.next ; 
        }
        for (int i = 1; i<= idB ; i++ ) {
            runB = runB.next ; 
        }

        // System.out.println (codeNodeA) ;
        // System.out.println (codeNodeB) ;
        // System.out.println (idA) ;
        // System.out.println (idB) ;
        // System.out.println (longestCommon) ;

        while ( idA < sizeA && idB < sizeB ) {
            // System.out.print("idA :") ;
            // System.out.println (idA) ;
            if(runA == runB) return runA ;

            else {
                runA = runA.next ;
                runB = runB.next ;
                idA ++ ; idB++; 
            }
        }
         
        return res  ;
        
    }

//     exception : 4
// [2,2,4,5,4]
// [2,2,4,5,4]
// 2
// 2

//     0
// [1,3,5,7,9,11,13,15,17,19,21]
// [2]
// 11
// 1
 public ListNode getIntersectionNode2(ListNode headA, ListNode headB) {
        //boundary check
    if(headA == null || headB == null) return null;
    
    ListNode a = headA;
    ListNode b = headB;
    
    //if a & b have different len, then we will stop the loop after second iteration
    while( a != b){
    	//for the end of first iteration, we just reset the pointer to the head of another linkedlist
        a = a == null? headB : a.next;
        b = b == null? headA : b.next;    
    }
    
    return a;
    }


    public ListNode getIntersectionNode3(ListNode headA, ListNode headB) {
        Set<ListNode> hs=new HashSet<>();
        while(headA!=null ){
            hs.add(headA);
                headA=headA.next;
            }
         while(headB!=null){
             if(hs.contains(headB))
             return headB;
             headB=headB.next;
         }   

        return null;
    }

}