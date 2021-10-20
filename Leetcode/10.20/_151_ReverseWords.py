class Solution:
    # https://blog.finxter.com/python-join-list-in-reverse-order/#:~:text=The%20most%20efficient%20method%20to,%5B%3A%3A%2D1%5D%20.
    def reverseWords(self, s: str) -> str:
        res = ''
        pre = ' '
        for c in s:
            if c != ' ':
                res += c
            elif pre != ' ':
                res += c
            pre = c
        return ' '.join(reversed(res.split(' '))).lstrip()

    # RES : Runtime: 45 ms, faster than 36.57% of Python3
    # Memory Usage: 14.4 MB, less than 37.09% of Python3
