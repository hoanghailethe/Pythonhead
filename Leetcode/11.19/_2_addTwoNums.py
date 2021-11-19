# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


class Solution:
    # Runtime: 68 ms, faster than 78.17% of Python3 o
    # Memory Usage: 14.2 MB, less than 73.39% of Python3
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        resultlist = curr = ListNode(0)  # we need two varibles because if only one variable is used we might loose reference to the head
        carry = 0
        while l1 or l2 or carry:  # not none
            if l1 is not None:
                carry += l1.val
                l1 = l1.next  # increase value of l1
            if l2 is not None:
                carry += l2.val
                l2 = l2.next
            curr.next = ListNode(carry % 10)  # retur remainder of division
            curr = curr.next
            carry = carry // 10  # returns floor value of division

        return resultlist.next


    def addTwoNumbers2(self, l1, l2):
        def toint(node):
            return node.val + 10 * toint(node.next) if node else 0
        def tolist(n):
            node = ListNode(n % 10)
            if n > 9:
                node.next = tolist(n / 10)
            return node
        return tolist(toint(l1) + toint(l2))


    def addTwoNumbers3(self, l1, l2):
        def toint(node):
            return node.val + 10 * toint(node.next) if node else 0
        n = toint(l1) + toint(l2)
        first = last = ListNode(n % 10)
        while n > 9:
            n /= 10
            last.next = last = ListNode(n % 10)
        return first