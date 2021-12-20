class Solution:
    # Runtime: 888 ms, faster than 30.60%
    def arrangeCoins(n: int) -> int:
        row = 0
        while n > row:
            row = row + 1
            print('*' * row)
            n = n- row
        print('*' * n)
        return row

print(Solution.arrangeCoins( n=18))