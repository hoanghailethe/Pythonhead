class Solution:
#     Runtime: 52 ms, faster than 25.42% of Python3 online submissions for Subtract the Product and Sum of Digits of an Integer.
# Memory Usage: 13.8 MB, less than 95.78% of Python3 online submissions for Subtract the Product and Sum of Digits of an Integer.
    def subtractProductAndSum(self, n: int) -> int:
        sum = 0
        product = 1

        while n > 0:
            digit = n % 10 
            sum += digit
            product *= digit
            n = int (n / 10)

        return product - sum 