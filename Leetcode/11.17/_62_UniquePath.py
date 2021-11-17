class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        # Dynamics Programing to shrink to Problem but first for easier implementation
        # Ưe must find the Recursion formula for this problem
        # REcursion F:  A ( M, N ) 	equals	 A( M-1;N) + A (M; N-1)
        if m == 1:
            return 1
        if n == 1:
            return 1

        return self.uniquePaths(m - 1, n) + self.uniquePaths(m, n - 1)
        # Good result but time limited Exceed, now we improve by adding memory

# Runtime: 36 ms, faster than 35.38% of Python3
# Memory Usage: 14.9 MB, less than 5.19% of Python3
    def uniquePaths2(self, m: int, n: int) -> int:
        memo = {}

        def dynamic(row: int, col: int) -> int:
            if row == 1 or col == 1:
                memo[str(row) + ":" + str(col)] = 1
                return 1

            k1 = str(row) + ":" + str(col)
            k2 = str(col) + ":" + str(row)
            if k1 in memo:
                return memo[k1]
            if k2 in memo:
                return memo[k2]

            memo[k1] = dynamic(row-1, col) + dynamic(row, col-1)
            return memo[k1]

        return dynamic(m, n)

# faster:
    # def uniquePathsDP(m, n, mem):
    #     if (m,n) not in mem:
    #         if m==1 or n==1:
    #             mem[(m,n)] = 1
    #         else:
    #             mem[(m,n)] = uniquePathsDP(m-1, n, mem) + uniquePathsDP(m, n-1, mem)
    #     return mem[(m,n)]

    def uniquePaths3(self, m: int, n: int) -> int:
        ## DP with 2d/dict
        # mem = {}
        # return uniquePathsDP(m, n, mem)

        ## DP with 1d
        # mem = [1 for j in range(n)]
        # for i in range(1, m):
        #     for j in range(1, n):
        #         mem[j] = mem[j]+mem[j-1]
        # return mem[n-1]

        ## math with permutation
        if m == 1 or n == 1: return 1
        result = 1
        m -= 1
        n -= 1
        m, n = min(m, n), max(m, n)
        for i in range(m):
            result *= m + n - i
        for i in range(m):
            result //= m - i
        return result


    def uniquePaths4(self, m: int, n: int) -> int:
        grid = [[1] * n for _ in range(m)]
        for col in range(1, n):
            for row in range(1, m):
                grid[row][col] = grid[row][col - 1] + grid[row - 1][col]

        return grid[m - 1][n - 1]