class Solution {
    public boolean canJump(int[] nums) {
        int max = 0 ; 

        // ArrayList<Integer> failIdList = new ArrayList<Integer>() ;
        if(canJumpFromToEnd(0,  nums ) ) return true ;
  
        return false ;
    } 

    public boolean canJumpFromToEnd (int from , int[] nums ) {

        // if (failIdList.contains(from)) return false ;
        if (nums[from] ==  -1 ) return false ;

        if (from + nums[from ] >= nums.length -1 ) return true ;
  
        for (int i = 1  ; i<= nums[from] ; i ++) {
            if(canJumpFromToEnd(from+i, nums) ) return true ;
        }

        // before fail save first
        // failIdList.add(from) ;
        nums[from] = -1 ;

        return false ;
    } 

    // Time Limit Exceeded     75 / 172 testcases passed
//     Java
// Runtime
// 162 ms
// Beats
// 17.16%
// Memory
// 44.5 MB
// Beats
// 42.86%

    public boolean canJump2(int[] nums) {
        int farthest = 0 ; 
        int n = nums.length ;

        for (int i = 0 ; i< n -1; i++) {
            farthest = Math.max(farthest, nums[i] + i ) ;

            if(nums[i] == 0 && i < n - 1 && i == farthest ) return false ;
        }
        return true ;
    }
}

// The only condition it returns false is when
// the best I can reach is an 0
// and the index is not the destination
// func canJump(nums []int) bool {
//     // the best I can reach
//     farthest := 0
//     n := len(nums)

//     for i := 0; i < n; i++ {
//         if i + nums[i] > farthest {
//             farthest = i + nums[i]
//         }

//         if nums[i] == 0 && i < n - 1 && i == farthest {
//             return false
//         }
//     }

//     return true
// }