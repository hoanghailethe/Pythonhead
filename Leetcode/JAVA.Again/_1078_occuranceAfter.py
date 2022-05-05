class Solution:
#     Runtime: 38 ms, faster than 56.72% of Python3 online submissions for Occurrences After Bigram.
# Memory Usage: 13.9 MB, less than 23.73% of Python3 online submissions for Occurrences After Bigram.
    def findOcurrences(self, text: str, first: str, second: str) -> List[str]:
        i = 0 
        res = []
        x = text.split()
        while i < len(x)-2:
            if x[i] == first and x[i+1] == second and x[i + 2] != first and x[i+2] != second:
                res.append(x[i+2])
                i+=2
                continue
            i += 1 
        return res 