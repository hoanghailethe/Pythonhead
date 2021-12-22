class Solution:
    # Runtime: 204 ms, faster than 59.12% of Python3
    # Memory Usage: 15.8 MB, less than 61.82% of
    def findErrorNums(self, nums: List[int]) -> List[int]:
        map_ticker = {}
        res = []
        for num in nums:
            count = map_ticker.get(num, 0) + 1
            if count == 2:
                res.append(num)
            map_ticker[num] = count

        for num in range(1, len(nums) + 1):
            if num not in  map_ticker.keys():
                res.append(num)
                break
        return res