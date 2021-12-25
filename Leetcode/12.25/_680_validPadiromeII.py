class Solution:
    # Runtime: 216 ms, faster than 19.06% of Python3
    # Memory Usage: 14.5 MB, less than 92.24% o
    def validPalindrome(self, s: str) -> bool:
        return self.validPalindromeMine(s, 0)

    def validPalindromeMine(self, s: str, time: int) -> bool:
        if time > 1:
            return False
        left = 0
        right = len(s) - 1
        while left < right:
            if s[left] != s[right]:
                return self.validPalindromeMine(s[:left] + s[left + 1:], time + 1) or self.validPalindromeMine(
                    s[:right] + s[right + 1:], time + 1)
            left += 1
            right -= 1

        return True