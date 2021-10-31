class Solution(object):
    # https://leetcode.com/problems/permutations/discuss/1548379/Python-92.5-faster-easy-to-understand

    def permute(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        res = [nums]
        i = 0
        while i < len(nums):
            # j = i + 1
            # while j < len(nums):
            #     nl = nums[:]
            #     # sway position i and j in num then add to res
            #     temp = nl[i]
            #     nl[i] = nl[j]
            #     nl[j] = temp
            #     res.append(nl)
            #     j += 1
            factor = nums[i]
            nl = nums[:]
            nl.remove(factor)
            for j in range(i, len(nums)):
                nl2 = nl[:]
                if j > i:
                    nl2.insert(j, factor)
                    res.append(nl2)
            i += 1
        # remove duplicate
        res = list(dict.fromkeys(res))
        return res
