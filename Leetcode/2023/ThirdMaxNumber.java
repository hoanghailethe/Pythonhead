class Solution {
    public int thirdMax(int[] nums) {
        Set<Integer> set = new HashSet()  ;

        for( int num : nums ) {
            set.add(num ) ;
        }
        ArrayList<Integer>  listNum = new ArrayList(set) ;
        Collections.sort(listNum, Collections.reverseOrder()) ;

        if (listNum.size() >= 3) {
            return listNum.get(2) ;
        } else return listNum.get(0 ) ;
    }
    Runtime
Details
6ms
Beats 28.51%of users with Java
Memory
Details
43.10mb
Beats 92.85%of users with Java

    public int thirdMax(int[] nums) {
        long max1 = Long.MIN_VALUE;
        long max2 = Long.MIN_VALUE;
        long max3 = Long.MIN_VALUE;
        for(int num : nums){
            if(num > max1){
                max3 = max2;
                max2 = max1;
                max1 = num;
            }
            else if(max1 > num && num > max2){
              max3 = max2;
              max2 = num;  
            }
            else if(max2 > num && num > max3){
              max3 = num;  
            }
        }
        return max3 == Long.MIN_VALUE?(int)max1: (int)max3;
    } 
    public int thirdMax(int[] nums) {
        Arrays.sort(nums);
        int distinctCount = 1;
        
        for (int i = nums.length - 2; i >= 0; i--) {
            if (nums[i] != nums[i + 1]) {
                distinctCount++;
                if (distinctCount == 3) {
                    return nums[i];
                }
            }
        }
        
        return nums[nums.length - 1];
    }
}