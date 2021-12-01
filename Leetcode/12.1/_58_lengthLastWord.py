class Solution:
    # Runtime: 20 ms, faster than 99.17% of Python3
    # emory Usage: 14.3 MB, less than 36.85%
    def lengthOfLastWord(self, s: str) -> int:
        meetWord = False
        res = 0
        s_id = len(s) - 1

        while s_id >= 0:
            charac = s[s_id]

            if not meetWord:
                if charac == ' ':
                    s_id -= 1
                    continue
                else:
                    meetWord = True
            elif charac != ' ':
                res += 1
            else:
                return res + 1
            s_id -= 1

        return res + 1
