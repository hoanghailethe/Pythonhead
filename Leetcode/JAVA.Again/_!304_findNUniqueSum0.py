class Solution:
#     Runtime: 45 ms, faster than 55.89% of Python3 online submissions for Find N Unique Integers Sum up to Zero.
# Memory Usage: 14 MB, less than 16.50% of Python3 online submissions for Find N Unique Integers Sum up to Zero.
    def sumZero(self, n: int) -> List[int]:
        res = [] 
        begin = 1
        if n % 2 != 0: res.append(0)
        for i in range(int(n/2)):
            random_number = random.randint(begin, begin+ 9)
            res.append(random_number)
            res.append(0-random_number)
            begin += 10
        return res