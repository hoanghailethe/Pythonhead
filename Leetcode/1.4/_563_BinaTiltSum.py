# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def findTilt(self, root: Optional[TreeNode]) -> int:
        if root:
            return abs(self.get_node_val(root.left) + self.findTilt(root.left) - self.get_node_val(root.right) - self.findTilt(root.right)) + self.findTilt(root.left) + self.findTilt(root.right)
        else:
            return 0 

    def get_node_val(self, root: Optional[TreeNode]) -> int:
        if root:
            return root.val
        else:
            return 0
