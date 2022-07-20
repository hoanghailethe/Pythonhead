class Solution(object):
    def removeDuplicates(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        id = 0
        run = 1
        subMode = False
        while run < len(nums) :
            print(str(id)+ ' ' +str(nums[id]) )
            print(str(run) + ' ' +str(nums[run]) )
            if subMode == False:
                if nums[run ] != nums[id]:
                    subMode = True
                    id = run
                id += 1
                
            else : 
                # Not sub mode id standstill
                if nums[id] != nums[run]:
                    nums[id] = nums[run]
                    subMode = False

            run += 1

        return id + 1

    def removeDuplicates2(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        my_set = {}
        save_id = 0 
        end_id = 0
        for idx, num in enumerate(nums):
            if num not in my_set:
                my_set[num] = True
                end_id = idx
            else :
                start = max( save_id, idx + 1 )
                if start > len(nums) - 1: break

                for i in range(start,len(nums) ) :
                    if nums[i] == num:
                        continue
                    else: 
                        my_set[nums[i]] = True
                        nums[idx] = nums[i]

        return end_id + 1

# Runtime: 61 ms, faster than 97.09% of Python online submissions for Remove Duplicates from Sorted Array.
# Memory Usage: 14.8 MB, less than 43.66% of Python online submissions for Remove Duplicates from Sorted Array.
        def removeDuplicates(self, nums: List[int]) -> int:
            temp = nums[0]
            counts = 1
            for i in range(1, len(nums)):
                if nums[i] != temp:
                    nums[counts] = nums[i]
                    temp = nums[i]
                    counts+=1
            return counts