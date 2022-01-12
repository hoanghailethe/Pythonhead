# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def sumRootToLeaf(self, root: Optional[TreeNode]) -> int:
        ele = []
        a = ''

        def rootToChild(strin, node):
            if node:
                if not node.right and not node.left:
                    ele.append(strin + str(node.val))

                else: 
                    rootToChild(strin + str(node.val), node.left)
                    rootToChild(strin + str(node.val), node.right)            
                
            else:
                ele.append(strin)
        rootToChild(a, root)
        if not root.left:
            ele.pop(0)
        if not root.right:
            ele.pop() 
        res = 0
        for ele in ele:
            # print(ele)
            print(int(ele, 2))
            res += int(ele, 2)
        return res
    
    # still wrong
    # def sumRootToLeaf(self, root: Optional[TreeNode]) -> int:
    #     m_queue = [root]
    #     ele_sum = ['']
    #     while m_queue:
    #         size_que = len(m_queue)
    #         for i in range(size_que):
    #             node = m_queue.pop()
    #             if node: 
    #                 m_queue.insert(0, node.left)
    #                 m_queue.insert(0, node.right)
    #                 new_ele_sum = []
    #                 for y in ele_sum:
    #                     z = y
    #                     print(str(z) + str(node.val))
    #                     new_ele_sum.append(str(z) + str(node.val))
    #                 ele_sum = new_ele_sum
        
    #     print(ele_sum)
    #     res = 0
    #     for ele in ele_sum:
    #         print(ele)
    #         print(int(ele, 2))
    #         res += int(ele, 2)
    #     return res

# [1,0,1,0,1,0,1]

# 1
# 10
# 101
# 1010
# 10101
# 101010
# 1010101
# ['1010101']
# 1010101
# 85

