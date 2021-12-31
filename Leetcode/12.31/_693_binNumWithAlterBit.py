class Solution:
    # Runtime: 53 ms, faster than 5.75% of Python3
    # Memory Usage: 14.3 MB, less than 40.12%
    def hasAlternatingBits(self, n: int) -> bool:
        bits = format(n, "b")
        return all(bits[i] != bits[i+1] for i in range(len(bits)-1))

