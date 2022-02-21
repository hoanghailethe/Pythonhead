import java.util.HashMap;

public class _169_MajorityElement {
//     Runtime: 11 ms, faster than 30.59% of Java online submissions for Majority Element.
// Memory Usage: 55.9 MB, less than 21.51% of Java online submissions for Majority Element.
    public int majorityElement(int[] nums) {
        
        HashMap <Integer, Integer> myMap = new HashMap<>();
        int compareTo = nums.length / 2;
        for(int num : nums) {
            int time = myMap.getOrDefault(num, 0) + 1;

            if (time > compareTo) return num;
            myMap.put(num, time);
        }

        return 0;
    }
    // Faster
    public int majorityElement2(int[] nums) {
        int count = 0;
        int x = 0;
        for(int i : nums){
            if(count == 0){
                x=i;
            }
            if(i == x){
                count++;
            }else{
                count--;
            }
        }
        return x;
    }
}
