class Solution {
    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> res = new ArrayList() ;

        int[] nArray = new int[n] ;

        for (int i = 0 ; i < nArray.length ; i ++ ) {
            nArray[i] = i + 1; 
        }

        int r = 0 ;
        List<Integer> collector = new ArrayList () ;
        collectCombine ( r , nArray , collector ,    res , k )  ; 
        
        // for (int i = 0 ; i < nArray.length ; i ++ ) {
        //     List<Integer> collector = new ArrayList () ;

        //     collectCombine ( r , nArray , collector ,    res , k )  ; 
        // }

        return res ;
    }

    public void collectCombine( int pos , int[] arr , List<Integer> collector ,  List<List<Integer>>res , int count  ) {
        if(count == 0 ) {
            res.add (collector ) ;
            return ;
        }
        collector.add(arr[pos]) ;

        for(int i = pos + 1 ; i < arr.length ; i++ ) {
            List<Integer> copy = new ArrayList<>(collector);
            collectCombine ( i ,  arr , copy , res , count-1 ) ; 
        }
    }
}