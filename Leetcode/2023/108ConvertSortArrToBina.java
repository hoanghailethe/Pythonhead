public class 108ConvertSortArrToBina {
// Runtime
// 0 ms
// Beats
// 100%
// Memory
// 43 MB
// Beats
// 77.29%
    public TreeNode sortedArrayToBST(int[] nums) {
        TreeNode root = null; 
        int size = nums.length ;
        
        root = ballanceTreeFromArr(nums, 0, size-1);
        
        return root ;
    }

    public TreeNode ballanceTreeFromArr(int[] nums, int from, int to) {
if (to < from) return null; 

        int arrLength = to - from + 1;

        if(arrLength == 1 ) return new TreeNode(nums[from]) ;

        int midIndex = from + (arrLength-1) / 2 ; 
        
        TreeNode node = new TreeNode(nums[midIndex ]);
        // System.out.println(midIndex) ;

        node.left = ballanceTreeFromArr(nums, from,  midIndex -1 ) ;
        node.right = ballanceTreeFromArr(nums, midIndex + 1, to) ;
        return node ;
        
    }
}
