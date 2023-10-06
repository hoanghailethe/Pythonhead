public class 703KLargestNoInStream {
    int largestKThNum;
    int[] nums;
    int ind = 0;
    int k = 0;
    ArrayList<Integer>numsInt =new ArrayList();

    public KthLargest(int k, int[] nums) {
        Arrays.sort(nums);
        this.nums =nums;
         
        largestKThNum = nums[ nums.length-k  ];
        this.k = k ;

        for (int i =  nums.length-k ; i<nums.length ; i++ ){
            numsInt.add(nums[i]);
        }
    }
    
    public int add(int val) {
        if(val > largestKThNum) {
            // this.ind++ ;
            binaInsert(val);
            largestKThNum = this.numsInt.get(this.numsInt.size()-k);
        }
        return largestKThNum ;
    }

    public void binaInsert (int val) {
        
        int beg=0 ;
        int end=this.numsInt.size()-1;

        if(this.numsInt.get(end) < val) {
            this.numsInt.add(val);
            System.out.println(this.numsInt);
            return;
        }
        while(end > beg ) {
            
            int mid = (beg +end) /2 ;

            if( this.numsInt.get(mid) < val && this.numsInt.get(mid + 1) >val ) {beg =mid+1 ;break;}
            if ( this.numsInt.get(mid) > val ) end = mid ;
            else  beg =mid + 1;
        }
	    this.numsInt.add( beg, val ); 

        System.out.println(this.numsInt);
    }
}
