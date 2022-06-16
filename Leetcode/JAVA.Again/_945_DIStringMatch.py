from turtle import distance


class Solution:
    def diStringMatch(self, s: str) -> List[int]:
        current = 0
        res = [current] 
        distance_no = int(2 * len(s))

        for letter in s : 
            if letter == 'I':
                current += distance_no
            else : 
                current -= distance_no
            res.append(current) 
            distance_no = int(distance_no / 2)

        return res

#         Wrong Answer
# Runtime: 23 ms
# Your input
# "IDID"
# Output
# [0,8,4,6,5]
# Expected
# [0,4,1,3,2]