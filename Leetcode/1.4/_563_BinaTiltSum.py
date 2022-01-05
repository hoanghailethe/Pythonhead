# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    # Runtime: 568 ms, faster than 5.68% of Python3
    # Memory Usage: 16 MB, less than 86.31% of Python3
    def findTilt(self, root: Optional[TreeNode]) -> int:
        if root:
            return abs(self.get_node_val(root.left) - self.get_node_val(root.right)) + self.findTilt(root.left) + self.findTilt(root.right)
        else:
            return 0 

    def get_node_val(self, root: Optional[TreeNode]) -> int:
        if root:
            return root.val + self.get_node_val(root.left) + self.get_node_val(root.right)
        else:
            return 0

#better way:vRuntime: 76 ms, faster than 46.08% of Python3.vMemory Usage: 16.5 MB, less than 30.79% 
    def findTilt2(self, root: Optional[TreeNode]) -> int:

            # returns (tilt_sum, value_sum)
            def process(node):
                if not node:
                    return (0, 0)
                
                left_tilt, left_sum = process(node.left)
                right_tilt, right_sum = process(node.right)
                return (left_tilt + right_tilt + abs(left_sum - right_sum), left_sum + right_sum + node.val)
            
            return process(root)[0]

    def findTilt3(self, root: Optional[TreeNode]) -> int:
        
        total_tilt = 0
        
        def sumNode(node):
            nonlocal total_tilt
            if not node:
                return 0
            left_sum = sumNode(node.left)
            right_sum = sumNode(node.right)
            tilt = abs(left_sum - right_sum)
            total_tilt += tilt
            return left_sum + right_sum + node.val
        
        sumNode(root)
        