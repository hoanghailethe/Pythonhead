class Solution:
    # Runtime: 756 ms, faster than 63.43% of Python3
    def maxSubArray(self, nums: List[int]) -> int:
        # dynamic programing here
        # dynamic programing here
        storage = []
        maxim = nums[0]
        storage.append(nums[0])
        for i in range(1, len(nums)):
            storage.append(max(storage[i - 1] + nums[i], nums[i]))
            if storage[i] > maxim:
                maxim = storage[i]


    # here is the full way: use Kadanes' Algorithm
    # Runtime: 796 ms, faster than 39.71% of Python3
    def maxSubArray2(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]
        sum = 0
        maxim = nums[0]
        for i in range(0, len(nums)):
            maxim = max(sum + nums[i], maxim)
            sum = max(0, sum + nums[i])

        return maxim