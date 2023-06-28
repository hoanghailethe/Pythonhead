class Solution(object):
    def searchInsert(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: int
        """
        minI = 0
        maxI = len(nums) -1 
        return self.BinaSearch(nums, target, minI, maxI)
    
    def BinaSearch(self, nums, target, minI, maxI):
        minV = nums[minI]
        maxV = nums[maxI]
        midI = int (math.ceil ((minI + maxI) / 2 ) ) 

       
        print('minI: ' + str(minI) + ',maxI: ' + str(maxI) +',midI: ' + str(midI) + ' ,midV:' + str(nums[midI]))

        if target == nums[midI] :
            return midI

        elif minV >= target : 
            return minI
        elif maxV <= target :
            return maxI
        elif target < nums[midI] :
            return self.BinaSearch(nums,target, minI, midI)
        else :
            return self.BinaSearch(nums,target, midI, maxI)
        
class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
	
        left = 0
        right = len(nums) - 1
		
		# Binary Search
		
        while left <= right:
            
			mid = (left+right)//2
			
            if nums[mid] == target:
                return mid
            elif nums[mid] < target:
                left = mid + 1
            else:
                right = mid - 1
				
        return left        

class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        
        left = 0
        right = len(nums) - 1
        
        # Recursive Binary Search
        def recursiveBinarySearch(nums: List[int], left, right, target: int) -> int:

            while left <= right:
                
                mid = (left+right)//2
                
                if nums[mid] == target:
                    return mid
                elif nums[mid] < target:
                    left = mid + 1
                    return recursiveBinarySearch(nums, left, right, target)
                else:
                    right = mid - 1
                    return recursiveBinarySearch(nums, left, right, target)
                
            return left
        
        return recursiveBinarySearch(nums, left, right, target)