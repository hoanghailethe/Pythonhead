class Solution:
    # Runtime: 176 ms, faster than 45.76%
    # Memory Usage: 15.8 MB, less than 86.36%
    def findContentChildren(self, g: List[int], s: List[int]) -> int:
        g.sort()
        s.sort()
        idg = 0
        ids = 0
        # count = 0

        while idg < len(g) and ids < len(s):
            if g[idg] > s[ids]:
                ids += 1
            else:
                ids += 1
                idg += 1
                # count += 1
        return idg
