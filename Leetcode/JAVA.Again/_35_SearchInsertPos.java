class Solution {
    public int searchInsert(int[] nums, int target) {
        int begin = 0;
        int end = nums.length - 1 ;
        // int mid = (begin + end ) / 2;

        return findIndex( nums , begin, end , target );

    }

    private int findIndex(int[] nums, int begin, int end, int target) {
        // if (begin > end ) return begin; 

        int mid = (begin + end ) / 2;
        if ( mid == begin ) mid = begin + 1;
        // System.out.println(" mid " + mid + " begin " + begin + " end " +end);
        if (target <= nums[begin] ) return begin;
        if (target == nums[end] ) return end; 
        if (target > nums[end] ) return end + 1; 

        if ( target > nums[begin] ) {
            // if( nums[begin + 1] >= target ) return begin + 1;
            // else 
            return findIndex(nums, mid, end, target);
        }

        if (target < nums[end]) {
            return findIndex(nums, begin, mid, target);
        }

        return begin;
    }

    // Runtime: 1 ms, faster than 10.94% of Java online submissions for Search Insert Position.
    // Memory Usage: 43 MB, less than 75.43% of Java online submissions for Search Insert Position.
    public int searchInsert(int[] nums, int target) {
        int left=0;
        int right=nums.length-1;
        int ans=0;
        while(left<=right)
        {
            int mid=left+(right-left)/2;
            if(nums[mid]==target)
            {
                return mid;
            }
            else
            {
                if(nums[mid]>target)
                {
                    right=mid-1;
                    ans=mid;
                }
                else
                {
                    left=mid+1;
                    ans=mid+1;
                }
            }
        }
        return ans;
    }
}