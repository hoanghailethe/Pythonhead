class Solution:
    # Runtime: 92 ms, faster than 60.49% of Python3
    def countBits(self, n: int) -> List[int]:
        ans = []
        for num in range(0, n + 1):
            str_bina = "{0:b}".format(num)
            ans.append(str_bina.count('1'))
        return ans
    