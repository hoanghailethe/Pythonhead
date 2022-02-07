# Definition for singly-linked list.
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None

class Solution:
    # Runtime: 103 ms, faster than 14.07% of Python3
    # Memory Usage: 17.7 MB, less than 54.18% of Python
    def hasCycle(self, head: Optional[ListNode]) -> bool:
        if not head or not head.next or not head.next.next:
            return False
        slow, fast = head.next, head.next.next

        while fast.next and fast.next.next:
            slow = slow.next
            fast = fast.next.next

            if fast.val == slow.val:
                return True
                
        return False 