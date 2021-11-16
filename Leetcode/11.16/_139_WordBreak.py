from typing import List


class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        strg = s
        while wordDict and len(strg) > 0:
            word = wordDict[0]
            if strg.find(word) != -1:
                # print(strg.find(word))
                # print(strg.find(word) + len(word))
                if strg.find(word) == 0:
                    strg = strg[strg.find(word) + len(word):]
                else:
                    strg = strg[0: strg.find(word)] + strg[strg.find(word) + len(word):]
                    print(strg)
            else:
                wordDict.remove(word)
        return len(strg) == 0

    def wordBreak2(self, s: str, wordDict: List[str]) -> bool:
        strg = s
        for word in wordDict:
            if strg.find(word) == -1:
                return False
        return True
