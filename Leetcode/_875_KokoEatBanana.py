import math


class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        total_banana = sum(piles)
        average =  total_banana / h 
        minSpeed = math.ceil(average)
        # k 
        isFirst = True
        for banana in piles:
            if banana * h >= total_banana and ( isFirst or banana < minSpeed):
                if isFirst: isFirst = False
                minSpeed = banana
                

        return minSpeed

class Solution2:
    # LIMITE TIME EXCEEDED
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        # Create a two dimenstional array like this:
        #   [  3, 8 ,30 ,10 and AVR_Speed ]
        # 3    1, 3, 10, 4   => Sum -- take minSpeed = AVR_Speed  if SUM hour > h and if SUM < min
        # 8 
        # 30 
        # 10
        total_banana = sum(piles)
        average =  total_banana / h 

        possible_speeds = [ math.ceil( average ) ] + piles
        possible_speeds.sort(reverse=True)
        # print(possible_speeds)
        minSpeed = possible_speeds[0]

        for speed in possible_speeds:
            if speed < average: break

            total_hour_speed = 0
            for banana in piles:
                total_hour_speed += math.ceil( banana / speed )
                if total_hour_speed > h : break 
            
            if total_hour_speed <= h:
                minSpeed = speed 
            else: break

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

    # TEST:
    #     [3,6,7,11]
    #     8

    # [30,11,23,4,20]  5