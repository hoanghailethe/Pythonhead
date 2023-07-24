public class 349IntersectionArr {
    public int[] intersection(int[] nums1, int[] nums2) {
	int [] chk = new int[1001] ;
	Set<Integer>intersect = new HashSet<>() ;
	for(int i = 0 ; i < nums1.length ; i ++) {
		chk[nums1[i]]=1 ;
	}        
	for(int i = 0 ; i < nums2.length ; i ++) {
		if(chk[nums2[i]]==1)intersect.add(nums2[i]) ;
	}
	int[]res = new int[intersect.size()] ;
	int id = 0 ;
	for(int i : intersect) {
		res[id++] = i ;	
}
	return res; 
}
}

Runtime
Details
1ms
Beats 97.59%of users with Java
Memory
Details
43.60mb
Beats 57.53%of users with Java

