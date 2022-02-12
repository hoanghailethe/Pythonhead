class Solution:
#     Runtime: 282 ms, faster than 5.06% of Python3 online submissions for Smallest Range I.
# Memory Usage: 15.5 MB, less than 11.39% of Python3 online submissions for Smallest Range I.
    def smallestRangeI(self, nums: List[int], k: int) -> int:
        min_num, max_num = min(nums), max(nums)

        if (min_num + k >= max_num - k):
            return 0
        else:
            return max_num - k - min_num - k 

        # mn = min(nums)
        # mx = max(nums)
            
        # return max(mx - mn - 2*k, 0)