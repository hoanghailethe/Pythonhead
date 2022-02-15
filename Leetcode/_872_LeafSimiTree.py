# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    # 39/40
#     Runtime: 93 ms, faster than 5.13% of Python3 online submissions for Leaf-Similar Trees.
# Memory Usage: 14 MB, less than 74.02% of Python3 online submissions for Leaf-Similar Trees.
    def leafSimilar(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> bool:
        
        queue = []

        def load_val_from1(root: Optional[TreeNode]) : 
            if not root:
                return 
            if not root.left and not root.right:
                queue.insert(0, root.val)
            load_val_from1(root.left)
            load_val_from1(root.right)

        load_val_from1(root1)

        def check_val_with2(root: Optional[TreeNode] ) -> bool :
            if not root:
                return True 
            if queue: 
                if not root.left and not root.right:
                    return queue.pop() == root.val 
            else:
                return False           
            return check_val_with2( root.left ) and check_val_with2(root.right)
        return check_val_with2(root2) and not queue

#         FAIL:
#         [3,5,1,6,7,4,2,null,null,null,null,null,null,9,11,null,null,8,10]
# [3,5,1,6,2,9,8,null,null,7,4]

# Runtime: 51 ms, faster than 32.58% of Python3 online submissions for Leaf-Similar Trees.
# Memory Usage: 13.9 MB, less than 86.74% of Python3 online submissions for Leaf-Similar Trees.

    def leafSimilar2(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> bool:
            if not(root1) or not(root2):
                return False
            def dfs(root, list):
                if not(root.left) and not(root.right):
                    list.append(root.val)
                if root.left:
                    dfs(root.left, list)
                if root.right:
                    dfs(root.right, list)
                return list
            # leaves_root1, leaves_root2 = [], []
            return dfs(root1, []) == dfs(root2, [])
            # return leaves_root1 == leaves_root2