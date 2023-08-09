public class 521LongestUncomSubseq {

//     Runtime
// Details
// 1ms
// Beats 100.00%of users with Java
// Memory
// Details
// 39.78mb
// Beats 100.00%of users with Java

    public int findLUSlength(String a, String b) {
        // the RESULT could only be- 1 OR the length of the SHORTer -? WHY- just logical resoning
        // iscommonSub
        // sub common - > the first letter appear of each charracter 
        String baseStr = a;
        if (a.length() < b.length()) {
            baseStr = b ;
            return b.length() ;
        }


        String longStr = baseStr.equals(a) ? b : a ;

        if(isSubseqOf(baseStr, longStr))return -1 ;
        //s1:all possible subsequnce of a 
        //s2 check if 

        return baseStr.length() ;

    }

    public boolean isSubseqOf(String baseStr , String longStr){

        ArrayList<Integer> runingPosSeq = new ArrayList<>() ;
        // ArrayList<Integer> runingPos = new ArrayList<>() ;
        for(char c : baseStr.toCharArray()) {
            ArrayList<Integer> runingPos = new ArrayList<>() ;

            int start = 0 ;
            while( longStr.indexOf(c ,start ) != - 1 ) {
                int idEx= longStr.indexOf(c ,start ) ;
                start = idEx +1; 
                runingPos.add(idEx) ;
            } 

            int minPrevInd =Integer.MIN_VALUE ;
            if (runingPosSeq.isEmpty()==false ) minPrevInd = Collections.min(runingPosSeq);

            Iterator<Integer> iterator = runingPos.iterator();
            while (iterator.hasNext()) {
                Integer index = iterator.next();
                if (index<minPrevInd) {     //firstRound not remove
                    iterator.remove();
                }
            }
            for(int ind: runingPos ) {
                if(ind<minPrevInd)runingPos.remove(ind) ;
            }
            runingPosSeq=runingPos ;

            if(runingPosSeq.isEmpty()) return false ;
        }
        return true ;
    }

}
