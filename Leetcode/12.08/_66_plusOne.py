class Solution:
    # untime: 41 ms, faster than 21.41% of Python
    def plusOne(self, digits: List[int]) -> List[int]:
        last = len(digits) - 1
        summ = 10
        while summ >= 10 and last >= 0:
            digits[last] += 1
            if digits[last] >= 10:
                digits[last] -= 10
                last -= 1
            else:
                summ = 0
        if last == -1:
            digits.insert(0, 1)
        return digits

    def plusOne2(self, digits: List[int]) -> List[int]:
        temp_str = ''
        for i in digits:
            temp_str += str(i)

        temp_res = int(temp_str) + 1
        return list(str(temp_res))