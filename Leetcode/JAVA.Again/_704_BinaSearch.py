class Solution:
    def search(self, nums: List[int], target: int) -> int:
        end = len(nums)-1
        return self.BS(0, end, target, nums)

    def BS(self, begin: int, end: int, target: int, nums: List[int]) -> int:
        if begin == end and nums[begin] != target:
            return -1
        
        mid = floor((begin + end)/2)
        if nums[mid]==target: return mid
        elif nums[mid] > target: return self.BS(begin, mid, target, nums)
        else: return self.BS(mid, end, target, nums)


# RecursionError: maximum recursion depth exceeded in comparison
#     if begin == end and nums[begin] != target:
# Line 7 in BS (Solution.py)
#   [Previous line repeated 996 more times]
#     else: return self.BS(mid, end, target, nums)
# Line 13 in BS (Solution.py)
#     else: return self.BS(mid, end, target, nums)
# Line 13 in BS (Solution.py)
#     else: return self.BS(mid, end, target, nums)
# Line 13 in BS (Solution.py)
# Last executed input
# [-1,0,3,5,9,12]
# 2