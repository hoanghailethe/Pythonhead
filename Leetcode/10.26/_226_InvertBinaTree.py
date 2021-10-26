# Definition for a binary tree node.
from typing import Optional


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    # Runtime: 57 ms, faster than 9.49% of Python3
    # Memory Usage: 14.2 MB, less than 46.18%
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if root is None:
            return

        temp = root.right
        root.right = root.left
        root.left = temp

        self.invertTree(root.right)
        self.invertTree(root.left)

        return root


    def swap_left_right(self: TreeNode, node: TreeNode):
        temp = node.right
        node.right = node.left
        node.left = temp
        return


    # Runtime: 32 ms, faster than 76.07%
    # Memory Usage: 14.2 MB, less than 46.18%
    def invertTree2(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if root is None:
            return root

        listNode = [root]

        while len(listNode) > 0:
            node = listNode.pop()
            self.swap_left_right(node)
            if node.right is not None:
                listNode.append(node.right)
            if node.left is not None:
                listNode.append(node.left)

        return root
