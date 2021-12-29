class Solution:
    # Runtime: 352 ms, faster than 67.03% of
    # Memory Usage: 14.4 MB, less than 49.33% o
    def findMaxConsecutiveOnes(self, nums: List[int]) -> int:
        max_conse = 0
        count = 0

        for num in nums:
            if num == 1:
                count += 1
            else:
                max_conse = max(count, max_conse)
                count = 0

        max_conse = max(count, max_conse)
        return max_conse

    def findMaxConsecutiveOnes2(self, nums: List[int]) -> int:
        i = j = max_count = 0
        for j in nums:
            if j == 1:
                i += 1
            else:
                if max_count < i:
                    max_count = i
                i = 0

        return max(i, max_count)

    def findMaxConsecutiveOnes3(self, nums: List[int]) -> int:
        count = 0
        m = 0
        for x in nums:
            if not x:
                m = max(m, count)
                count = 0
            else:
                count += 1
        m = max(m, count)
        return m