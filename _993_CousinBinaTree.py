# Definition for a binary tree node.
from typing import Optional, List


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


class Solution:
    # Runtime: 28 ms, faster than 93.30% of Python3
    # Memory Usage: 14.3 MB, less than 71.37%
    def isCousins(self, root: Optional[TreeNode], x: int, y: int) -> bool:
        vals = [x, y]
        queue = [root]
        if root is None:
            return False

        while len(queue) > 0:
            add = []
            size = len(queue)
            for i in range(size):
                nodeA = queue.pop(len(queue)-1)
                sameTurn = False

                if nodeA.left and nodeA.left.val in vals:
                    vals.remove(nodeA.left.val)
                    sameTurn = True
                if nodeA.right and nodeA.right.val in vals:
                    vals.remove(nodeA.right.val)
                    if sameTurn:
                        return False
                if len(vals) > 1:
                    if nodeA.left:
                        add.insert(0, nodeA.left)
                    if nodeA.right:
                        add.insert(0, nodeA.right)

            if len(vals) == 0:
                return True
            elif len(vals) == 1:
                return False
            else:
                queue.extend(add)
        return False

