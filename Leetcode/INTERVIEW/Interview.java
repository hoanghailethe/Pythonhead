import java.util.Arrays;
import java.util.Collection;

// https://stackoverflow.com/questions/57857855/could-not-find-or-load-main-class-vs-code

public class Interview {
    /**
     * @param args
     * @throws Exception
     */
//    public static void main1(String[] args) {
//        String empty = " ";
//        String abc = "abc" ;
//        // CheckValidString1 checker1 = new CheckValidString1();
//
//
//
//    }

    // question 1

    // public static String password123(String[] passwords, String checkString) {

    //     Integer noOfCap = null ;

    //     int curs = 0 ;

    //     String first = null ;
    //     String second = null ;
    //     String third = null ;

    //     while(first == null && curs < checkString.length()- 4 ) {

    //         if( isNumeric( checkString.substring(0, curs+1) ) ) {
    //             curs++;
    //         }
    //         if( !(checkString.charAt(curs+1) >= '0' && checkString.charAt(curs+1) <= '9') ) {
    //             first = checkString.substring(0, curs+2);
    //         }

    //     }



    //     for (int i = 0 ; i < checkString.length() ; i++ ){

    //     }


    //     // int numUpperCase = Integer.parseInt(checkString.charAt(0) + "");
    //     String last3Reversed = new StringBuilder(checkString.substring(1, 4)).reverse().toString();
    //     int sumDigits = Integer.parseInt(checkString.substring(4));
    
    //     for (String password : passwords) {
    //         int upperCaseCount = 0;
    //         String last3 = password.substring(password.length() - 3);
    
    //         for (int i = 0; i < password.length(); i++) {
    //             if (Character.isUpperCase(password.charAt(i))) {
    //                 upperCaseCount++;
    //             }
    //         }
    
    //         int digitSum = 0;
    //         for (char c : password.toCharArray()) {
    //             if (Character.isDigit(c)) {
    //                 digitSum += c - '0';
    //             }
    //         }
    
    //         if (upperCaseCount == numUpperCase && last3.equals(last3Reversed) && digitSum == sumDigits) {
    //             return password;
    //         }
    //     }
    
    //     return "";
    // }


    public static String password(String[] passwords, String checkString) {

        Integer numUpperCase= -1 ;
        String last3Reversed = "" ;
        Integer sumDigits = 0 ;

        // System.out.print(checkString.length()) ;
        if(checkString.length() != 5) return null ;


        numUpperCase = Integer.parseInt(checkString.charAt(0) + "");
        last3Reversed = new StringBuilder(checkString.substring(1, 4)).reverse().toString();
        sumDigits = Integer.parseInt(checkString.substring(4));
        
        for (String password: passwords) {
            // System.out.print(password) ;
            int upperCaseCount = 0;
            String last3 = password.substring(password.length() - 3);
        
            for (int i = 0; i < password.length(); i++) {
                if (Character.isUpperCase(password.charAt(i))) {
                    upperCaseCount++;
                }
            }
            
        
            int digitSum = 0;
            for (char c : password.toCharArray()) {
                if (Character.isDigit(c)) {
                    digitSum += c - '0';
                }
            }
        
            if (upperCaseCount == numUpperCase && last3.equals(last3Reversed) && digitSum == sumDigits) {
                System.out.println(password) ;
                return password;
            }
        }
        
        return null;
    }

    //javac Interview.java
    // java -cp . Interview 

    
    public static void main(String[] args) {
        String[] testArr = {"P@sSwORD1", "20passWORD20", "PASS6word"};

        String[] testArr2 = {"luckyPASSWORD#$$$"," luckyDay666", "PASS6word"};

        

        // System.out.println(password(testArr, "4dro6"));

        // System.out.println(password(testArr2, "6pass7"));

        // put parameters: (new String[] {"luckyPASSWORD#$$$"," luckyDay666",}, new String("6pass7")) ;

        System.out.println(password(new String[] {"luckyPASSWORD#$$$"," luckyDay666",}, new String("6pass7")));

        System.out.println(password(new String[] {"luckyPASSWORD#$$$"," luckyDay666","Mypassword2", "crazyPassword1#$%"}, new String("1%$#1")));

        System.out.println(password(new String[] {"theBestpassword","myPassword#3"}, new String("1dro0")));
    }
}
// You have a list of passwords and just one chance to enter the correct one.
// You are provided with the so-called "check string", where:
// • The first character is a digit that represents the number of uppercase symbols in the correct password.
// • The next 3 characters are last 3 characters of the correct password in reverse order. W
// The last characters represent the sum of all digits in the password.
// Find the correct password.
// Examples:
// Input: [P@sSwORD1, 20passWORD20, PASSword] , 4dro
// Output: PASSword
// Input: [theBestpassword, myPassword#3], 1dro®
// Output: theBestpassword
// Input: [MyPassword2, crazyPassword1#$%], 1%$#1
// Output: crazyPassword1#$%

//     public static int checkPassword (Integer[] nums) {
        
//         Integer noOfCap = null ;

//         int curs = 1 ;

//         String first = "" ;
//         String second = "" ;
//         String third = "" ;

//         for (int i = 0 ; i <3; ){

//         }

//     }


//     public static boolean isNumeric(String strNum) {
//         Pattern pattern = Pattern.compile("-?\\d+(\\.\\d+)?");

//         if (strNum == null) {
//             return false; 
//         }
//         return pattern.matcher(strNum).matches();
//     }


//     public static int Average (Integer[] nums) {
//         if (nums.length == 0) return 0;
//         int sum = 0 ;
//         for (Integer num : nums) {
//             sum += num;
//         }
//         return sum / nums.length ;
//     }


//     public static void main2(String[] args) {
//         Integer[] nums = {1,33,55 ,99} ;
//         int average = Average(nums) ;
//         System.out.println(average);

//         if(average >= 10 ) {
//             System.out.println("Double digits");
//         } else {
//             System.out.println("Single digits");
//         }

//         //test new CASTing Collection on 231122
//         String[] testarr = {"123", "!2412512" , "oki "} ;
// 		Collection c = (Collection) Arrays.asList(testarr) ;
// 		System.out.println(c);
//     }


// }


