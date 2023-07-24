public class 350Intersection2Arr {
    public int[] intersect(int[] nums1, int[] nums2) {
        int [] chk = new int[1001] ;
        List<Integer>intersect = new ArrayList<>() ;
        for(int i = 0 ; i < nums1.length ; i ++) {
            chk[nums1[i]]++ ;
        }        
        for(int i = 0 ; i < nums2.length ; i ++) {
            if(chk[nums2[i]]>0){
                intersect.add(nums2[i]) ; 
                chk[nums2[i]]-- ;
            }
        }
        int[]res = new int[intersect.size()] ;
        int id = 0 ;
        for(int i : intersect) {
            res[id++] = i ;	
    }
        return res; 
    }
}
