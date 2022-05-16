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
            else:
                return divisable(str[:-len(sc)], sc)
            
        if len(str1) < len(str2): 
            minStr = str1
            maxStr = str2
        else: 
            minStr = str2
            maxStr = str1
        sc = minStr
        i = len(sc) - 1
        while i > 0:
            if divisable(minStr, sc) and divisable(maxStr[minLen:], sc) :
                return sc
            else : sc = sc[:-1]
            i -= 1

        return ""


        # FAIL CASE: 
        # Input
        # "AAAAAAAAA"
        # "AAACCC"
        # Output
        # "AAA"
        # Expected
        # ""