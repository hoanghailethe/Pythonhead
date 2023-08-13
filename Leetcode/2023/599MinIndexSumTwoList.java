public class 599MinIndexSumTwoList {
    public String[] findRestaurant(String[] list1, String[] list2) {
        
        int miSum=Integer.MAX_VALUE ;
        List<String>res = new ArrayList() ;
        Map<String, Integer>commonStr = new HashMap() ;

        for(int i =0; i< list1.length; i++) {
            commonStr.put(list1[i], i) ;
        }

        for(int i = 0;  i < list2.length; i++ ) {
            if(commonStr.keySet().contains(list2[i])) {

                int sum = i  + commonStr.get(list2[i]) ;

                if( sum< miSum ) {
                    res = new ArrayList()  ;
                    res.add( list2[i] ) ;
                    miSum= Math.min(miSum , sum );
                } else if(sum==miSum){
                    res.add( list2[i] ) ;
                }
           
                commonStr.remove(list2[i]);
            }
        }
        String[] arr = res.toArray(new String[0]);
        return  arr;
    }

    Runtime
Details
8ms
Beats 82.72%of users with Java
Memory
Details
44.40mb
Beats 81.00%of users with Java

}
