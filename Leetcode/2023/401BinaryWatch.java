class Solution {
    public List<String> readBinaryWatch(int turnedOn) {

        if(turnedOn > = 9) return new Arraylist() ;

        List<String>res = new Arraylist() ;

        int[] HOUR = {8,4,2,1} ;
        int[] MINMUTE = {32,16,8,4,2,1} ;

        int LedOn = turnedOn ;

        int hour = 0 ;
        int minute = 0  ;

        int r = 0 ; 

        Arraylist<Integer> index =new Arraylist() ;

        while(LedOn > 0 ) {
            index.add(ledOn--);
        }
        
        for(int i : index ) {


        }


        return res ;




    }
    public List<String> readBinaryWatch(int turnedOn) {

        if(turnedOn > = 9) return new Arraylist() ;

        List<String>res = new Arraylist() ;

        int[] HOUR = {8,4,2,1} ;
        int[] MINMUTE = {32,16,8,4,2,1} ;

        
        int hour = 0 ;
        int minute = 0  ;

        for(int hourOn = 1; hourOn < HOUR.length && turnedOn - hourOn >= 0 ; hourOn++) {

            int minOn = turnedOn - hourOn ;


        }

        return res 
    }

public class Solution {
    public List<String> readBinaryWatch(int num) {
        List<String> res = new ArrayList<>();
        int[] nums1 = new int[]{8, 4, 2, 1}, nums2 = new int[]{32, 16, 8, 4, 2, 1};
        for(int i = 0; i <= num; i++) {
            List<Integer> list1 = generateDigit(nums1, i);
            List<Integer> list2 = generateDigit(nums2, num - i);
            for(int num1: list1) {
                if(num1 >= 12) continue;
                for(int num2: list2) {
                    if(num2 >= 60) continue;
                    res.add(num1 + ":" + (num2 < 10 ? "0" + num2 : num2));
                }
            }
        }
        return res;
    }

    private List<Integer> generateDigit(int[] nums, int count) {
        List<Integer> res = new ArrayList<>();
        generateDigitHelper(nums, count, 0, 0, res);
        return res;
    }

    private void generateDigitHelper(int[] nums, int count, int pos, int sum, List<Integer> res) {
        if(count == 0) {
            res.add(sum);
            return;
        }
        
        for(int i = pos; i < nums.length; i++) {
            generateDigitHelper(nums, count - 1, i + 1, sum + nums[i], res);    
        }
    }
}

public List<String> readBinaryWatch(int num) {
       List<String> result = new ArrayList<String>();
       int[] hours = new int[] { 8, 4, 2, 1 }, minutes = new int[] { 32, 16, 8, 4, 2, 1 };
       for (int pick = 0; pick <= num; pick++) {
	   if (pick > 5 || num - pick > 3) continue; // We can only make less than 3 picks from hours and 5 picks from minutes
	   List<Integer> minuteCombination = pickHelper(pick, 1, minutes, 0, 0, new ArrayList<Integer>(), 59);
	   List<Integer> hourCombination = pickHelper(num - pick, 1, hours, 0, 0, new ArrayList<Integer>(), 11);
	   for (int h : hourCombination)
		for (int m : minuteCombination)
		     if (m < 10) result.add(h + ":0" + m);
		     else result.add(h + ":" + m);
	}
	return result;
}

public List<Integer> pickHelper(int MaxPickTimes, int PickTimes, int[] times, int decimalTime, int startPick, List<Integer> Combination, int maxTime) {
       if (PickTimes > MaxPickTimes) {
          Combination.add(decimalTime);
	  return Combination;
       }
       for (int pick = startPick; pick < times.length; pick++) {
	    decimalTime += times[pick];
	    if (decimalTime <= maxTime) pickHelper(MaxPickTimes, PickTimes + 1, times, decimalTime, pick + 1, Combination, maxTime);
	    decimalTime -= times[pick];
       }
       return Combination;
}
}