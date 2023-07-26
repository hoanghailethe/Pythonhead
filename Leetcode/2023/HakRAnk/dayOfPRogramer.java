public class dayOfPRogramer {
    public static String dayOfProgrammer(int year) {
        // Write your code here
            int[] daysInMonth =new int[] { 31, 28,31,30, 31,30,31,31,30,31,30,31 } ;
            boolean newCalendar = false ;
            boolean isLeap =false ;
            int countDown =256 ;
            if(year==1918) daysInMonth[1]=15 ;
            if (year > 1918) {
                newCalendar = true ;
            }
            if(newCalendar) {
                isLeap = (year %4 == 0 && year %100 != 0) || 
                    year %400 == 0 ;
            } else {
                isLeap = (year %4 == 0);
            }
            
            StringBuilder sb = new StringBuilder() ;
            int month = 1 ;
            if(isLeap) {
                daysInMonth[1] += 1; 
            }
            while(countDown-daysInMonth[month-1]>0){
                countDown-=daysInMonth[month-1] ;
                month++;
            }
            if(countDown<10){
                sb.append('0');sb.append(countDown) ;
            } else sb.append(countDown) ;
            sb.append('.') ;
            if(month<10){
                sb.append('0');sb.append(month) ;
            } else sb.append(month) ;
            sb.append('.') ;
            sb.append(year);
            return sb.toString() ;
        }
}
