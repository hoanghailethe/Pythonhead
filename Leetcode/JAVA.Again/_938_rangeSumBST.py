# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
#     Runtime: 205 ms, faster than 97.30% of Python3 online submissions for Range Sum of BST.
# Memory Usage: 23 MB, less than 51.66% of Python3 online submissions for Range Sum of BST.
    def rangeSumBST(self, root: Optional[TreeNode], low: int, high: int) -> int:
        if root is None:
            return 0
        if low <= root.val <= high:
            return root.val + self.rangeSumBST(root.left, low, high) + self.rangeSumBST(root.right, low, high)
        elif root.val < high:
            return self.rangeSumBST(root.right, low, high)
        elif root.val > low:
            return self.rangeSumBST(root.left, low, high)
        