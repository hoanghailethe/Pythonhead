# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
class Solution:
#     Runtime: 92 ms, faster than 53.26% of Python3 online submissions for Merge Two Binary Trees.
# Memory Usage: 15.4 MB, less than 78.33% of Python3 online submissions for Merge Two Binary Trees
    def mergeTrees(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> Optional[TreeNode]:
        node = TreeNode()
        if root1 and root2:
            node.val = root1.val + root2.val
            node.left = self.mergeTrees(root1.left, root2.left)
            node.right = self.mergeTrees(root1.right, root2.right)
        elif root1 and not root2:
            node = root1
        elif root2 and not root1:
            node = root2         
        elif not root1 and not root2:
            return None
        return node