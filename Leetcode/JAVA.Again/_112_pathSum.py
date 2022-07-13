# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
from operator import truediv

# Input
# [1,2]
# 3
# Output
# false
# Expected
# true
class Solution(object):
    def hasPathSum(self, root, targetSum):
        """
        :type root: TreeNode
        :type targetSum: int
        :rtype: bool
        """
        if root == None:
            return False
        if root.left == None and root.right == None :
            return root.val == targetSum    
        elif root.left == None and root.right != None :
            return  self.recursivePathSum(root.right, targetSum - root.val)
        elif root.left != None and root.right != None :
            return self.recursivePathSum(root.left, targetSum - root.val )
        else:
            return False

    def recursivePathSum(self, root, targetSum) : 
        # print(targetSum)
        if root == None :
            return targetSum == 0 
        return self.recursivePathSum(root.left, targetSum - root.val ) or  self.recursivePathSum(root.right, targetSum - root.val )