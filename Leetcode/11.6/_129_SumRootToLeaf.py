# Definition for a binary tree node.
from typing import List, Optional


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


# Runtime: 28 ms, faster than 86.23% of Python3
# Memory Usage: 14.3 MB, less than 48.31%
class Solution:
    def sumNumbers(self, root: Optional[TreeNode]) -> int:
        num_to_add = []
        self.addSumLeaves(root, num_to_add, 0)
        return sum(num_to_add)

    def addSumLeaves(self, root, num_to_add: List[int], val: int):
        if root is None:
            return
        if root.right is None and root.left is None:
            add = val * 10 + root.val
            # print(add)
            num_to_add.append(add)
            return
        else:
            add = val * 10 + root.val
            self.addSumLeaves(root.right, num_to_add, add)
            self.addSumLeaves(root.left, num_to_add, add)
