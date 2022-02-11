class Solution:
#     Runtime: 36 ms, faster than 57.85% of Python3 online submissions for Rotate String.
# Memory Usage: 13.9 MB, less than 93.22% of Python3 online submissions for Rotate String
    def rotateString(self, s: str, goal: str) -> bool:
        rotateS = ''

        for index, letter  in enumerate(s) :
            rotateS = s[index:] + s[:index]
            if rotateS == goal:
                return True
        return False
         
