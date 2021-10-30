
from typing import List


class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        # index = 0
        pre_num = nums[0]
        slow_index = 1
        for index in range(1, len(nums)):
            while pre_num == nums[index] and index != len(nums) - 1:
                index += 1
            nums[slow_index] = nums[index]
            slow_index += 1
            pre_num = nums[index]
        return slow_index


    def removeDuplicates2(self, nums: List[int]) -> int:
        if len(nums) < 2:
            return
        l, r = 0, 1
        while r < len(nums):
            if nums[l] != nums[r]:
                l += 1
                nums[l] = nums[r]
            r += 1
        return l + 1

    # back to my solution
    # Runtime: 88 ms, faster than 73.59% of Python3
    # Memory Usage: 15.7 MB, less than 47.85% of Python3
    def removeDuplicates3(self, nums: List[int]) -> int:
        if len(nums) < 2:
            return
        slow, index = 1, 1
        pre = nums[0]
        while index < len(nums):
            if nums[index] == pre:
                index += 1
            else:
                nums[slow] = nums[index]
                pre = nums[slow]
                slow += 1
        return slow


a = Solution()
print(Solution.removeDuplicates2(a, nums=[0, 0, 1, 1, 1, 2, 2, 3, 3, 4]))
