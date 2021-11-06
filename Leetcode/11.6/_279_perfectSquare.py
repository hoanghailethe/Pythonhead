
class Solution(object):
    def numSquares(self, n, memo = {}):
        if n in memo:
            return memo[n]
        if n <= 0:
            return 0

        i = 1
        # worst case scenario, it's a sum of 1, hence the result would be = to the target number
        best_result = n
        while i*i <= n:
            diff = n - i*i
            result = self.numSquares(diff, memo) +1
            if result < best_result:
                best_result = result
            i+=1
        memo[n] = best_result