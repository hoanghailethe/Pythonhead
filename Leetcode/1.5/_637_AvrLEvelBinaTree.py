# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    #Runtime: 92 ms, faster than 6.37% of Python3
    #Memory Usage: 16.6 MB, less than 33.17% 
    def averageOfLevels(self, root: Optional[TreeNode]) -> List[float]:
        res =[]
        my_que = [root]
        while my_que:
            level_num = len(my_que)
            level_ele = []
            for i in range(level_num):
                node = my_que.pop()

                if node:
                    my_que.insert(0,node.left)
                    my_que.insert(0,node.right)
                    level_ele.append(node.val)
            if level_ele:
                res.append( sum(level_ele) / len(level_ele) )
        return res

    def averageOfLevels2(self, root: Optional[TreeNode]) -> List[float]:
        if not root: return root
        ans = []
        q = deque([root])
        
        while q:
            t = 0
            y = len(q)
            for i in range(len(q)):
                x = q.popleft()
                t += x.val
                if x.left:q.append(x.left)
                if x.right:q.append(x.right)
            ans.append(t/y)
        
        return ans