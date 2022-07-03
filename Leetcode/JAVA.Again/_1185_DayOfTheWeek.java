import java.util.Calendar;
import java.util.Date;

public class _1185_DayOfTheWeek {
    public String dayOfTheWeek(int day, int month, int year) {
        // Date date  = new Date(year, month, day);
        Calendar cal = Calendar.getInstance();
        cal.clear();
        cal.set(year + 1900, month, day);
        switch (cal.get(Calendar.DAY_OF_WEEK)){
            case Calendar.SUNDAY:     
                return "Sunday";
            case Calendar.MONDAY:     
                return "Monday";
            case Calendar.TUESDAY:     
                return "Tuesday";
            case Calendar.WEDNESDAY:     
                return "Wednesday";
            case Calendar.THURSDAY:     
                return "Thursday";
            case Calendar.FRIDAY:     
                return "Friday";
            default:     
                return "Saturday";            
        }
            
            
    }

    //without Lib
    public String dayOfTheWeek2(int day, int month, int year) {
        String[] week = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        int[] days = {31, isLeapYear(year) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int count = 0;
        for(int i = 1971;i<year;i++) {
            count += i % 4 == 0 ? 366 : 365;
        }
        for(int i=0;i<month-1;i++) {
            count += days[i];
        }
        count += day;
        return week[(count + 4) % 7];
    }
    
    private boolean isLeapYear(int year) {
        return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
    }

    public String dayOfTheWeek3(int day, int month, int year) {
        String answer = LocalDate.of(year, month, day).getDayOfWeek().toString();
        return answer.substring(0, 1).toUpperCase() + answer.substring(1).toLowerCase();
    }

    // String dayOfWeek = LocalDateTime.of(year, month, day, 10, 10).getDayOfWeek().toString();
        
    //     return dayOfWeek.charAt(0) + dayOfWeek.substring(1).toLowerCase();


}
