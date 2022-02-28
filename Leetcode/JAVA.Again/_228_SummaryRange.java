import java.util.ArrayList;

class Solution {
    public List<String> summaryRanges(int[] nums) {
        List<String> res = new ArrayList<>();
        if (nums.length == 0 ) return res;

        int pre =  nums[0];
        StringBuilder pen = new StringBuilder();
        pen.append(pre);

        for (int ind = 0;  ind < nums.length; ind++) { 

            int currentNumber = nums[ind];
            pen.setLength(0);
            while (ind + 1 < nums.length && nums[ind+1] - nums[ind] == 1) {
                ind++;
            }
            
            if(currentNumber != nums[ind]) {
                pen.append(currentNumber);
                pen.append("->");
                pen.append(nums[ind]);
            } else {
                pen.append(currentNumber);
            }
            res.add  (pen.toString());
        }
        
        return res;
    }
}

// TEST

// Input
// [0,2,3,4,6,8,9]
// Output
// ["0->0","2->4","6->6","8"]
// Expected
// ["0","2->4","6","8->9"]

// Accepted
// Runtime: 3 ms
// Your input
// [0,1,2,4,5,7]
// Output
// ["0->2","4->5","7"]
// Expected
// ["0->2","4->5","7"]