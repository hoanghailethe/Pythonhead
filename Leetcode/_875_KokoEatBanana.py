class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        total_banana = sum(piles)
        average = int(total_banana / h)
        
        piles.append(average)
        piles.append(average+1)
        piles.sort()
        print(piles)
        for speed in piles:
            if speed * h >= total_banana:
                return speed


    addedTime = h - len ()   (min == 0)
    for i = 1 -> added 
    5 => 8 
    id = 1 => added
        minSpeed = piles[ - (id+1)  ] 

        if id <= addedTime return :  

        added_degrade = added 
        for l in range( - (id+1), -1):
            added_degrade -= math.ceil( piles[ l ] /  minSpeed )
        if (  added_degrade >= 0 ) return minSpeed
        return piles[-1]