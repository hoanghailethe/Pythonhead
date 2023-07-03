class Solution {
//     Runtime
// 0 ms
// Beats
// 100%
// Memory
// 43.1 MB
// Beats
// 59.54%

    public int searchInsert(int[] nums, int target) {

        if(target > nums[nums.length - 1 ] ) return nums.length; 
        else if (target < nums[ 0  ] ) return 0;
        return searchBina(nums, 0, nums.length -1, target ) ;
    }

     public int searchBina (int[]nums, int left, int right, int target) {
        
        // if (target> right) return right + 1 ;
        if(left >= right ) return left ;

        int mid = (left+right) /  2 ;

        if(nums[mid] == target ) return mid ; 
        else if (nums[mid] > target ) return searchBina (nums, left, mid , target) ;
        else return searchBina(nums, mid + 1,  right , target  ) ;


    }
}