class Solution:
    # Runtime: 37 ms, faster than 42.51% of Python3
    # Memory Usage: 14.1 MB, less than 89.86%
    def constructRectangle(self, area: int) -> List[int]:
        w = int(math.sqrt(area))
        while area % w != 0:
            w -= 1
        l = int(area / w)

        return [l, w]


    def constructRectangle(self, area: int) -> List[int]:

        mid = int(math.sqrt(area))

        while mid > 0:
            if area % mid == 0:
                return [area // mid, mid]
            mid -= 1
            