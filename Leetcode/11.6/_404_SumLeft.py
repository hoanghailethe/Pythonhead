# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

# Runtime: 36 ms, faster than 43.33% of Python3
# Memory Usage: 14.9 MB, less than 34.55%
class Solution:
    def sumOfLeftLeaves(self, root: Optional[TreeNode]) -> int:
        if root is None:
            return 0
        res = 0
        if root.right:
            res += self.sumOfLeftLeaves(root.right)

        if root.left:
            if root.left.left is None:
                if root.left.right is None:
                    res += root.left.val
            res += self.sumOfLeftLeaves(root.left)

        return res
