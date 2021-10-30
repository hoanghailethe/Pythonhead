
# Runtime: 28 ms, faster than 94.95% of Python3
# Memory Usage: 14.2 MB, less than 76.64%
class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:
        index, run = 0, 0
        while run < len(nums):
            if nums[run] != val:
                nums[index] = nums[run]
                index += 1
            run += 1
        return index
