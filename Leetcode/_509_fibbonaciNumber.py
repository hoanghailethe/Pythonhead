class Solution:

#     Runtime: 32 ms, faster than 87.33% of Python3 online submissions for Fibonacci Number.
# Memory Usage: 13.9 MB, less than 55.33% of Python3 online submissions for Fibonacci Number.
    def fib(self, n: int) -> int:
        f0 = 0
        f1 = 1

        if n == 0: return f0
        if n == 1: return f1

        fn = f1 + f0 
        i = 2 

        while i < n : 
            fn = f1 + f0 
            f0 = f1
            f1 = fn
            i += 1
        return fn


    def fib(self, n: int) -> int:
        if(n <= 1):
            return n
        memo = [None] * (n+1)
        memo[0] = 0
        memo[1] = 1
        for i in range(2, n+1):
            memo[i] = memo[i-1] + memo[i-2]
        return memo[n]