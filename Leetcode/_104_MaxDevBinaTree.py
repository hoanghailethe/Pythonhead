# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:

# Runtime: 44 ms, faster than 76.53% of Python3 online submissions for Maximum Depth of Binary Tree.
# Memory Usage: 16.4 MB, less than 8.26% of Python3 online submissions for Maximum Depth of Binary Tree.
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        else:
            return max(self.maxDepth(root.left) , self.maxDepth(root.right)  ) + 1