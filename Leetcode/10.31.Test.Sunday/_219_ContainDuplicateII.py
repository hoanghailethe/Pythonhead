class Solution:
    # Runtime: 898 ms, faster than 21.23% of Python3
    # Memory Usage: 27.7 MB, less than 63.47%
    def containsNearbyDuplicate(self, nums: List[int], k: int) -> bool:
        map = {}
        for ind in range(len(nums)):
            i = map.get(nums[ind], -1)
            if i == -1:
                map[nums[ind]] = ind
            else:
                if abs(i - ind) <= k:
                    return True
                else:
                    map[nums[ind]] = ind
        return False
