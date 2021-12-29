class Solution:
    # Runtime: 40 ms, faster than 79.75% of Python3
    # Memory Usage: 14.8 MB, less than 78.08% of Python3
    def licenseKeyFormatting(self, s: str, k: int) -> str:
        s = s[::-1]
        res = ""
        count = 0
        for c in s:
            if c != '-':
                res += c
                count += 1
                if count == k:
                    res+='-'
                    count = 0
        # print(res)
        if res == '':
            return res
        if res[len(res)-1] == '-':
            res = res[:len(res)-1]
        res = res[::-1].upper()
        return res