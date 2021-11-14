from typing import List

# Runtime: 176 ms, faster than 39.31% of Python3
# Memory Usage: 14.8 MB, less than 9.00%
class Solution:
    def canPlaceFlowers(self, flowerbed: List[int], n: int) -> bool:
        max_flower_add = 0

        def can_planted(index):
            # global flower
            if flowerbed[index] == 0 and (index - 1 < 0 or flowerbed[index-1] == 0) and (index + 1 == len(flowerbed) or flowerbed[index+1] == 0):
                return True
            return False

        for i, cell in enumerate(flowerbed):
            if can_planted(i):
                flowerbed[i] = 1
                max_flower_add += 1
                i += 1

        return n <= max_flower_add


# better python:
    def canPlaceFlowers2(self, flowerbed: List[int], n: int) -> bool:
        plant = 0
        canPlant = True
        for i in range(len(flowerbed)):
            if flowerbed[i]:
                canPlant = False
            else:
                if canPlant:
                    if i + 1 >= len(flowerbed) or flowerbed[i + 1] == 0:
                        plant += 1
                        canPlant = False
                else:
                    canPlant = True
            if plant > n: return True
        return plant >= n