import math


class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        total_banana = sum(piles)
        average =  total_banana / h 

        minSpeed = math.ceil(average)
        # if minSpeed > average :
        #     return minSpeed

        isFirst = True
        for banana in piles:
            if banana * h >= total_banana and ( isFirst or banana < minSpeed):
                if isFirst: isFirst = False
                minSpeed = banana
                

        return minSpeed
                 


    # addedTime = h - len ()   (min == 0)
    # for i = 1 -> added 
    # 5 => 8 
    # id = 1 => added
    #     minSpeed = piles[ - (id+1)  ] 

    #     if id <= addedTime return :  

    #     added_degrade = added 
    #     for l in range( - (id+1), -1):
    #         added_degrade -= math.ceil( piles[ l ] /  minSpeed )
    #     if (  added_degrade >= 0 ) return minSpeed
    #     return piles[-1]