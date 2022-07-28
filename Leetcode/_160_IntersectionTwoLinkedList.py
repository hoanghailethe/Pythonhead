# Definition for singly-linked list.
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None

class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> Optional[ListNode]:
        res = None

        def nodeToString(node: ListNode, begin: str) -> str:
            if node is not None: 
                return nodeToString( node.next, begin + str(node.val) )
            return begin

        strA = nodeToString(headA, "")
        strB = nodeToString(headB, "")

        lenA = len(strA) - 1
        lenB = len(strB) - 1

        i = 0
        # preNode = None
        while lenA - i >= 0 or lenB -i >= 0:
            if lenA[lenA - i] != lenB[lenB - i] :
                return res
                break 
            else :
                preNode = res
                res = ListNode( lenA[lenA - i] , preNode )
            i += 1

        if i == 0:
            return ListNode(0, None) 
        else : 
            return res

        # my_set = []
        # curA = headA
        # curB = headB
        # while curA is not None or curB is not None :
        #     if curA is not None:
        #         if curA.val in my_set:
        #             return ListNode ( curA.val , curA.next )
        #         else :
        #             my_set.append(curA.val)
        #         curA = curA.next 

        #     if curB is not None:
        #         if curB.val in my_set:
        #             return ListNode ( curB.val , curB.next )
        #         else :
        #             my_set.append(curB.val)
        #         curA = curB.next 
        # return res