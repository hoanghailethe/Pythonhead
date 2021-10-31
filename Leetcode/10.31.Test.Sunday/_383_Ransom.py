class Solution(object):
    # Runtime: 109 ms, faster than 28.42% of Python
    def canConstruct(self, ransomNote, magazine):
        """
        :type ransomNote: str
        :type magazine: str
        :rtype: bool
        """
        mapm = {}
        for chara in ransomNote:
            count = mapm.get(chara, 0)
            mapm[chara] = count + 1

        for chara in magazine:
            count = mapm.get(chara, -1)
            if count != -1:
                mapm[chara] = count - 1

        for value in mapm.values():
            if value != 0:
                return False
        return True