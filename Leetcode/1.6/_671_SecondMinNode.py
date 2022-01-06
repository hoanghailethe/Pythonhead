# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    # Runtime: 46 ms, faster than 11.62% of Python3
    # Memory Usage: 14.3 MB, less than 47.79% 
    def findSecondMinimumValue(self, root: Optional[TreeNode]) -> int:
        holder = []
        my_que = [root]

        while my_que:
            lop_time = len(my_que)

            for i in range(lop_time):
                node = my_que.pop()
                if node:
                    holder.append(node.val)
                    my_que.insert(0, node.left)
                    my_que.insert(0, node.right)
        return self.secondMinSetVal(holder)

    def secondMinSetVal(self, holder: list) -> int:
        count = 0
        min1 = 99999999999
        min2 = 999999999999
        for val in holder:
            if count == 0:
                if val < min1:
                    count += 1
                    min1 = val
            else:   #count == 1 from
                if min1 < val < min2:
                    count += 1
                    if count == 3:
                        return val
                    min2 = val 
        if count == 2: return min2
        return -1

    def findSecondMinimumValue2(self, root: Optional[TreeNode]) -> int:
        second = float('inf')
        first = root.val
        
        def dfs(root):
            nonlocal second
            if root.val > first:
                second = min(second, root.val)
            
            if root.left:
                dfs(root.left)
                dfs(root.right)
            
        dfs(root)
        
        return -1 if second == float('inf') else second