public class 2784GoodArray {
//     Runtime
// Details
// 1ms
// Beats 99.62%of users with Java
// Memory
// Details
// 42.24MB
// Beats 23.70%of users with Java

    public boolean isGood(int[] nums) {
        // base[3] = [1, 2, 3, 3]
        // two condition :
        // length 
        // allnumber the same 
        // order not important

        int base = nums.length  - 1;
        if(base<=0) return false ;
        int[] diemdanh= new int[base] ;

        for(int i= 0 ; i< base; i++ ){
            diemdanh[i]++;
        }
        diemdanh[base-1]++;

        // System.out.print("time") ;
        // for(int time: diemdanh ){
        //     System.out.print(time) ;
        // }
        // System.out.println("end time") ;

        for(int num : nums ) {
            if(num>base)return false ;
            diemdanh[num-1]--;
        }
            for(int time: diemdanh ){
                if (time != 0) {
                    // System.out.print(time) ;
                    return false;
                }
            }

        return true ;
    }
}
