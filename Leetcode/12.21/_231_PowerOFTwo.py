class Solution:
    # Runtime: 16 ms, faster than 99.94%
    # Memory Usage: 14.1 MB, less than 89.51%
    def isPowerOfTwo(self, n: int) -> bool:
        begin = 1
        while n > begin:
            begin *= 2
        return begin == n