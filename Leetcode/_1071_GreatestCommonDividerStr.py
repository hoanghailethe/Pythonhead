

# Runtime: 44 ms, faster than 58.61% of Python3 online submissions for Greatest Common Divisor of Strings.
# Memory Usage: 14 MB, less than 5.77% of Python3 online submissions for Greatest Common Divisor of Strings.
class Solution:
    def gcdOfStrings(self, str1: str, str2: str) -> str:
        sc = ""
        minLen = min ( len(str1) , len(str2)  )
        minStr = ""
        maxStr = ""

        def divisable( str, sc ) : 
            # print(str)
            if len(str) < len(sc) or len(str) % len(sc) != 0:
                return False
            elif str == sc:
                return True
            elif str[-len(sc):] == sc:
                return divisable(str[:-len(sc)], sc)
            return False
            
        if len(str1) < len(str2): 
            minStr = str1
            maxStr = str2
        else: 
            minStr = str2
            maxStr = str1
        
        sc = minStr
        i = len(sc) - 1
        while i >= 0:
            if divisable(minStr, sc) and divisable(maxStr, sc) :
                return sc
            else : sc = sc[0:-1]
            i -= 1

        return ""