# https://leetcode.com/problems/perfect-squares/discuss/275311/Python-DP-and-BFS
# First solution is to use DP.
# Suppose dp[i] records to least number of perfect square numbers that sum up to i. And there are multiple ways for perfect square numbers to sum up to i.
# The candidate way is to add a perfect square number j*j to a sum of perfect square numbers that equals to i. And it can be generized as i-j*j + j*j. So the least number of perfect square numbers that sum up to i-j*j is dp[i-j*j]. So candidate answer is dp[i-j*j]+1(add one more number j*j).
# So for dp[i], we just pick the minimum of all candidates:
#
# dp[i] = min(dp[i-j*j] for j in range(1, int(i**0.5)+1)) + 1
# Time complexity is O(n√n). Actually running time is 2500ms.


def numSquares(n):
    dp = [0] + [float('inf')]*n
    for i in range(1, n+1):
        dp[i] = min(dp[i-j*j] for j in range(1, int(i**0.5)+1)) + 1
    return dp[n]


# Another solution is to use BFS.
# The root node is n, and we are trying to keep reduce a perfect square number from it each layer. So the next layer nodes are {n - i**2 for i in range(1, int(n**0.5)+1)}. And target leaf node is 0, indicates n is made up of a number of perfect square numbers and depth is the least number of perfect square numbers.


def numSquares2(self, n):
    squares = [i**2 for i in range(1, int(n**0.5)+1)]
    d, q, nq = 1, {n}, set()
    while q:
        for node in q:
            for square in squares:
                if node == square: return d
                if node < square: break
                nq.add(node-square)
        q, nq, d = nq, set(), d+1
# Each while loop takes Si, which is the number of the values that is within range {1, n} whose least number of perfect squares is i. E.g. S1 = √n.
# So total time cost should be c∑Si = cS1+cS2+...+cSd. Since I used a set for queue here, ∑Si ≤ n, and time complexity is O(n). The worst case would be n happen to have a larger least number of perfect square than any number from {1, n-1}. Actually running time is 220ms.