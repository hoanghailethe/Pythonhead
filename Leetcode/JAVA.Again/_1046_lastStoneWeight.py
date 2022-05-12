class Solution:
    def lastStoneWeight(self, stones: List[int]) -> int:
        stone_left = 0
        stones.sort(reverse=True)
        # print(stones)

        def binary_insert(stones, stone_left, startId, endId):
            begin = startId
            end = endId
            # print('begin ' + str(begin))
            if stones[begin] <= stone_left :
                if begin == 0 :
                    stones.insert(0, stone_left)
                else : stones.insert(begin-1, stone_left)
                return 

            if stones[end] >= stone_left :
                stones.insert(end+1, stone_left)
                return

            if end <= begin: 
                stones.insert(begin, stone_left)
                return

            mid = (int) ((begin + end) / 2)
            # print (' mid ' + str(mid))

            if stones[mid] > stone_left:
                binary_insert(stones, stone_left, mid + 1 , end )
            elif stones[mid] < stone_left:
                binary_insert(stones, stone_left, begin , mid - 1 )
            else:
                stones.insert(mid , stone_left)
                return 

        leng = len(stones)
        while leng > 1 :
            # print(stones)
            stone1 = stones.pop(0)
            stone2 = stones.pop(0)
            stone_left = abs( stone1 - stone2 )
            if not stones:
                return stone_left
            binary_insert(stones, stone_left,  0, len(stones) - 1)
            leng = len(stones)
            

        return stones[0]

    def lastStoneWeight(self, stones: List[int]) -> int:
        # binary add num to sorted nums list
        def add_num_tonums(nums, num): # add a num to a sorted nums list
            l = 0
            r = len(nums) -1
            while l <= r:
                mid = l + (r - l) // 2
                if nums[mid] == num:
                    #print (nums[:mid] + [num] + nums[mid:])
                    return nums[:mid] + [num] + nums[mid:]
                elif nums[mid] < num:
                    l = mid + 1
                else:
                    r = mid - 1
            #print (nums[:l] + [num] + nums[l:])
            return nums[:l] + [num] + nums[l:]
        
        #add_num_tonums([1,2,9],15)
        # sort stones 
        stones.sort()
        # loop and binary 
        while stones:
            if len(stones) == 1:
                return stones[0]
            else:
                m1 = stones.pop()
                m2 = stones.pop()
                val = m1- m2
                stones = add_num_tonums(stones, val)
        return 0