class Solution(object):
    # Runtime: 52 ms, faster than 50.99% of Python
    def isAnagram(self, s, t):
        """
        :type s: str
        :type t: str
        :rtype: bool
        """
        mapm = {}
        for chara in s:
            count = mapm.get(chara, 0)
            mapm[chara] = count + 1

        for chara in t:
            count = mapm.get(chara, 0)
            mapm[chara] = count - 1

        for value in mapm.values():
            if value != 0:
                return False
        return True
