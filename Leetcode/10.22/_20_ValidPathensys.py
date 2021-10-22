class Solution:
    # Runtime: 28 ms, faster than 89.92% of Python3
    # Memory Usage: 14.4 MB, less than 7.44%
    def isValid(self, s: str) -> bool:
        check = []
        for c in s:
            if c in ('(', '{', '['):
                check.append(c)
            else:
                if len(check) == 0:
                    return False

                out = check.pop()
                if c == ')' and out != '(':
                    return False
                if c == '}' and out != '{':
                    return False
                if c == ']' and out != '[':
                    return False
        return len(check) == 0
