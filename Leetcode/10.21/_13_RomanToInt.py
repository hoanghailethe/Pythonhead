class Solution:
    # Runtime: 48 ms, faster than 75.25% of Python3
    # Memory Usage: 14.3 MB, less than 26.67%
    def romanToInt(self, s: str) -> int:
        converter = {
            'I': 1,
            'V': 5,
            'X': 10,
            'L': 50,
            'C': 100,
            'D': 500,
            'M': 1000
        }
        res = 0
        pre = ''
        for cur in s:
            if (cur in ('V', 'X') and pre == 'I') or (cur in ('L', 'C') and pre == 'X') or (cur in ('D', 'M') and pre == 'C'):
                res += converter.get(cur) - 2 * converter.get(pre)
            else:
                res += converter.get(cur)
            pre = cur
        return res

    # better way in Python
    def romanToInt2(self, s: str) -> int:
        map = {'I': 1,
               'V': 5,
               'X': 10,
               'L': 50,
               'C': 100,
               'D': 500,
               'M': 1000}
        res = 0
        i = 0
        n = len(s)
        while i < n:
            if i < n - 1 and map[s[i]] < map[s[i + 1]]:
                res += map[s[i + 1]] - map[s[i]]
                i += 2
            else:
                res += map[s[i]]
                i += 1

        return res