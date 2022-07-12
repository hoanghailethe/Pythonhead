class Solution(object):
#     Runtime: 21 ms, faster than 66.14% of Python online submissions for Maximum 69 Number.
# Memory Usage: 13.5 MB, less than 33.86% of Python online submissions for Maximum 69 Number.
    def maximum69Number (self, num):
        """
        :type num: int
        :rtype: int
        """
        string_number = str(num)
        string_number_array = list(string_number)
        for id, string_digit in enumerate(string_number_array) :
            if string_digit == '6':
                string_number_array[id] = '9'
                break
        res= int("".join(string_number_array))
        return res