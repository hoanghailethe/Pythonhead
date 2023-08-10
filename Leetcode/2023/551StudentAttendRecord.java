public class 551StudentAttendRecord {
    public boolean checkRecord(String s) {
        char[]ca=s.toCharArray() ;
        boolean isLegit = true ;

        int countLateConsecutive = 0;
        int countAbsent =  0 ;

        for (char a : ca) {
            if (a=='A') {
                countLateConsecutive= 0;
                countAbsent++ ;
                if(countAbsent==2) return false ;
            } else if(a== 'L') {
                countLateConsecutive++ ;
                if(countLateConsecutive==3) return false ;
            } else {
                countLateConsecutive= 0;
            }

        }

        return isLegit ;
    }
//     Runtime
// Details
// -ms
// Beats 100.00%of users with Java
// Memory
// Details
// 40.41mb
// Beats 79.80%of users with Java
}
