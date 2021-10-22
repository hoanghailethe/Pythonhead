from typing import List


class Solution:

    # Runtime: 50 ms, faster than 27.92% of Python3 online
    # Memory Usage: 14.5 MB, less than 24.58% of Python3
    def longestCommonPrefix(self, strs: List[str]) -> str:
        com = strs[0]
        for str in strs:
            end = len(com)
            while end > 0:
                if str.find(com) == 0:
                    break
                else:
                    end -= 1
                    com = com[0:end]
        return com

    # Better run time 24ms
    def longestCommonPrefix2(self, strs: List[str]) -> str:
        if len(strs) == 0:
            return ""
        prefix = strs[0]
        for i in range(1, len(strs)):
            while not strs[i].startswith(prefix):
                prefix = prefix[:-1]
                if len(prefix) == 0:
                    return ""
        return prefix