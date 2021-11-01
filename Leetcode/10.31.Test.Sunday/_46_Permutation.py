class Solution(object):
    # https://leetcode.com/problems/permutations/discuss/1548379/Python-92.5-faster-easy-to-understand
    # video explain: https://leetcode.com/problems/permutations/discuss/1549135/RecursionBacktracking-based-solution-or-Interview-Style-Code-walk-through-or-Java-or-CPP


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



    def permute2(self, nums: List[int]) -> List[List[int]]:
        res = [nums]
        # i = 0
        for i in range(len(nums)):
            factor = nums[i]
            nl = nums[:]
            nl.remove(factor)
            for j in range(i + 1, len(nums)):
                nl2 = nl[:]
                nl2.insert(j, factor)
                res.append(nl2)

                # must be one more loop up to
        # remove duplicate
        # res = list(dict.fromkeys(res))
        return res


    def dfs(self, nums, path, res):
        if not nums: res.append(path); return;
        for i in range(len(nums)):
            self.dfs(nums[:i] + nums[i + 1:], path + [nums[i]], res)


    def permute4(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        res = []
        self.dfs(nums, [], res)
        return res


# DFS and backtracking python
class Solution2:
    def permute(self, nums: List[int]) -> List[List[int]]:

        result = []

        # --------------------------------------------------------------------------

        def dfs(cur_idx, cur_permu):

            if cur_idx == len(nums):
                # no more element, add current permutation to result list
                result.append(cur_permu[::])
                return

        for swap_idx in range(cur_idx, len(nums)):
            # swap head element
            nums[swap_idx], nums[cur_idx] = nums[cur_idx], nums[swap_idx]

            # add head element to current permutation
            cur_permu.append(nums[cur_idx])

            # DFS to next element
            dfs(cur_idx + 1, cur_permu)

            # restore original state
            cur_permu.pop()
            nums[swap_idx], nums[cur_idx] = nums[cur_idx], nums[swap_idx]

        # --------------------------------------------------------------------------
        dfs(cur_idx=0, cur_permu=[])
        return result