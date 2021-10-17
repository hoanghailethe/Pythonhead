from typing import List


# Runtime: 4432 ms, faster than 17.20% of Python
# Memory Usage: 15 MB, less than 65.79%
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        size = len(nums)
        res = []
        for i in range(size):
            for j in range(i + 1, size):
                if target - nums[i] == nums[j]:
                    res.append(i)
                    res.append(j)
        return res

    # better way:
    def twoSum2(self, nums: List[int], target: int) -> List[int]:
        keep = {}
        for i, num in enumerate(nums):
            rest = target - num
            if rest in keep:
                return [keep[rest], i]
            else:
                keep[num] = i

    # https://www.geeksforgeeks.org/enumerate-in-python

