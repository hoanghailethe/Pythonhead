class Solution:
    # Runtime: 428 ms, faster than 14.88% of Python3
    def containsDuplicate(self, nums: List[int]) -> bool:
        mySet = set()
        mySet.update(nums)
        return len(mySet) != len(nums)