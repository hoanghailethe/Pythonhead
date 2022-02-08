
class Solution:
# Runtime: 42 ms, faster than 48.40% of Python3 o
    def addDigits(self, num: int) -> int:
        if num >= 10 :
            return self.addDigits (self.addDigits(int(num/10)) + (num % 10) )
        else:
            return num