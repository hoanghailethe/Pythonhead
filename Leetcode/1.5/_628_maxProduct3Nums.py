class Solution:
    #Runtime: 402 ms, faster than 8.47% of Python3
    # Memory Usage: 15.5 MB, less than 44.93%
    def maximumProduct(self, nums: List[int]) -> int:
        nums.sort()
        return max( nums[0] * nums[1] * nums[-1] , nums[-3] * nums[-2] * nums[-1] )