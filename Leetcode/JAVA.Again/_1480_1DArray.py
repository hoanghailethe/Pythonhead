class Solution:
#     Runtime: 55 ms, faster than 54.23% of Python3 online submissions for Running Sum of 1d Array.
# Memory Usage: 14.2 MB, less than 27.03% of Python3 online submissions for Running Sum of 1d Array.
    def runningSum(self, nums: List[int]) -> List[int]:
        res = []
        runner = 0 
        for num in nums:
            runner += num
            res.append(runner)
        return res