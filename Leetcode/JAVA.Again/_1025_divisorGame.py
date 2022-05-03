class Solution:
#     Runtime: 55 ms, faster than 33.72% of Python3 online submissions for Divisor Game.
# Memory Usage: 13.8 MB, less than 59.44% of Python3 online submissions for Divisor Game.
    def divisorGame(self, n: int) -> bool:
        # if n <= 1: return False
        # for i in range(1, n):
        #     if n%i == 0 and self.divisorGame(n-i) == False:
        #         return True
        # return False

        if n % 2== 0:
            return True
        else :
            return False