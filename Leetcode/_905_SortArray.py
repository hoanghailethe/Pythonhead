class Solution:
#     Runtime: 171 ms, faster than 6.83% of Python3 online submissions for Sort Array By Parity.
# Memory Usage: 14.8 MB, less than 72.25% of Python3 online submissions for Sort Array By Parity.
    def sortArrayByParity(self, nums: List[int]) -> List[int]:
        odd = []
        even = []
        for id, num in enumerate(nums) :
            if num % 2 != 0 :
                even.append(num)
            else: odd.append (num)
        odd.extend(even)
        return odd


    def sortArrayByParity2(self, nums: List[int]) -> List[int]:
        length = len(nums)
        pos=0
        for i in range(length):
            if nums[i]%2==0:
                nums[pos], nums[i] = nums[i], nums[pos]
                pos+=1

        return nums