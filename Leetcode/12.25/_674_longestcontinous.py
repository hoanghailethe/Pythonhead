class Solution:
    # Runtime: 68 ms, faster than 94.08% of Python3
    # Memory Usage: 15.2 MB, less than 82.28% of Python
    def findLengthOfLCIS(self, nums: List[int]) -> int:
        if len(nums) == 0:
            return 0
        count = 1
        max_streak = 1
        pre = nums[0]
        for num in nums:
            if num > pre:
                count += 1
            else:
                max_streak = max(count, max_streak)
                count = 1
            pre = num
        max_streak = max(count, max_streak)
        return max_streak
