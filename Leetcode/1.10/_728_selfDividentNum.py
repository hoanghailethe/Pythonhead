class Solution:
    # Runtime: 74 ms, faster than 24.57%
    # Memory Usage: 14.1 MB, less than 94.55% of Python3
    def selfDividingNumbers(self, left: int, right: int) -> List[int]:
        res = []

        def isSelfDivNum(b:int):
            a = b
            # print(b)
            while a > 0:
                last_digit = a % 10
                # print(last_digit)
                if last_digit == 0 or b % last_digit != 0:
                    return False
                a = int(a / 10) 
            return True

        for a in range (left, right+1):
            if isSelfDivNum(a):
                res.append(a)
        return res

    def selfDividingNumbers2(self, left: int, right: int) -> List[int]:
		res = []
		for num in range(left, right+1):
			if num < 10:
				res.append(num)
			else:
				temp = num
				while temp != 0:
					div = temp % 10
					if div != 0 and num % div == 0:
						temp //= 10
					else:
						break
				if temp == 0:
					res.append(num)
		return res
