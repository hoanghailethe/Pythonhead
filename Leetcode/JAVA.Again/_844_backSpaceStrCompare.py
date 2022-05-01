class Solution:

#     Runtime: 65 ms, faster than 6.96% of Python3 online submissions for Backspace String Compare.
# Memory Usage: 13.9 MB, less than 77.17% of Python3 online submissions for Backspace String Compare.
    def backspaceCompare(self, s: str, t: str) -> bool:
        qs = []
        qt = []
        for i in s:
            if i != '#' :
                qs.append(i)
            elif qs:
                qs.pop()

        for i in t: 
            if i != '#' :
                qt.append(i)
            elif qt:
                qt.pop()
        if len(qt) != len(qs): 
            return False
        else :
            for i in range (len(qt)):
                if qt.pop() != qs.pop():
                    return False
            return True


