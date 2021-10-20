class Solution:
    def isPalindrome(self, x: int) -> bool:
        if x in range(0, 9):
            return True
        if x < 0 or x % 10 == 0:
            return False
        reverse = 0

        while reverse < x:
            reverse = int(reverse * 10 + x % 10)
            x = int(x / 10)
        # print(x)
        # print(reverse)
        return x == reverse or x == int(reverse / 10)

    # RES: Runtime: 94 ms, faster than 26.00% of Python3