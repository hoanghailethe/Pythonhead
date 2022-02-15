class Solution:
#     Runtime: 152 ms, faster than 65.82% of Python3 online submissions for Single Number.
# Memory Usage: 16.6 MB, less than 68.96% of Python3 online submissions for Single Number.
    def singleNumber(self, nums: List[int]) -> int:
        myMapStore = {}

        for num in nums:
            if num in myMapStore : 
                del myMapStore[num]
            else: 
                myMapStore[num] = True
        # print(myMapStore)
        return list( myMapStore.keys() )[0]