class Solution:
#     Runtime: 42 ms, faster than 65.90% of Python3 online submissions for Find the K-Beauty of a Number.
# Memory Usage: 14 MB, less than 15.56% of Python3 online submissions for Find the K-Beauty of a Number
    def divisorSubstrings(self, num: int, k: int) -> int:
        begin = num 
        count_beauty = 0 
        runner = 0
        divider = 1
        for i in range(k) : 
            divider *= 10

        while begin > 0 and begin >= int(divider/10) :
            print(runner)
            runner = begin % divider
            if runner != 0 and num % runner == 0 :
                count_beauty += 1
            begin = int(begin / 10) 

        return count_beauty