class Solution:
    # Runtime: 28 ms, faster than 94.35% of Python3
    def strStr(self, haystack: str, needle: str) -> int:
        if needle == "":
            return 0
        return haystack.find(needle)
