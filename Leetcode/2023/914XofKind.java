class Solution {
    public boolean hasGroupsSizeX(int[] deck) {
        Set<Integer> set = new HashSet() ;

        int totalSum= 0;
        int difNumSum=0;

        for(int x : deck) {
            totalSum +=x ;

            if(set.add(x)) {
                difNumSum+=x;
            }
        }

        boolean res = false ;
                // System.out.println(totalSum + " " + difNumSum + " "+deck.length + set.size()) ;
        if( deck.length > 1 && set.size() > 0 && totalSum% difNumSum == 0 && deck.length%set.size()==0&& totalSum/ difNumSum == deck.length/set.size() ){
            res=true ;
        }
        return res ;
    }
}