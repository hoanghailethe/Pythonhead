class Solution:
    # Runtime: 364 ms, faster than 60.25% of Python3
    # Memory Usage: 23.1 MB, less than 48.33%
    def findDisappearedNumbers(self, nums: List[int]) -> List[int]:
        n = len(nums)
        mapA = {}
        res = []

        for item in nums:
            if item not in mapA.keys():
                mapA[item] = 'y'

        for i in range(1, n + 1):
            if i not in mapA.keys():
                res.append(i)

        return res


    def findDisappearedNumbers2(self, nums: List[int]) -> List[int]:
        n = len(nums)
        mapA = {}
        res = []

        for i in range(0, n):
            if nums[i] not in mapA.keys():
                mapA[nums[i]] = 0
            else:
                mapA[i] += 1
                res.append(i)

        return res

    def findDisappearedNumbers3(self, nums: List[int]) -> List[int]:
        return list((set(range(1, len(nums) + 1))) - set(nums))


#untime: 336 ms, faster than 83.80% of Python3
# Memory Usage: 23.7 MB, less than 40.91%
    #uSE set Faster
    def findDisappearedNumbers4(self, nums: List[int]) -> List[int]:
        # First we want to remove duplicates, so we will create a searchable set()
        test_set = set()
        for num in nums:
            if num not in test_set:
                test_set.add(num)

        missing = []
        # found = []
        for i in range(1, len(nums) + 1):
            if not i in test_set:
                missing.append(i)
            # else:
            #   found.append(i)

        return missing