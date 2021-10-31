class Solution(object):
    # Runtime: 32 ms, faster than 32.47% of Python
    def longestCommonPrefix(self, strs):
        """
        :type strs: List[str]
        :rtype: str
        """
        com = strs[0]

        for stri in strs:
            while len(com) > 0:
                if stri.find(com) != 0:
                    break
                com = com[0:len(com) - 1]
            if len(com) == 0:
                break
        return com
