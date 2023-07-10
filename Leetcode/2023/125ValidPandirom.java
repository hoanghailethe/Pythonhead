public class 125ValidPandirom {
//     Runtime
// 7 ms
// Beats
// 51.90%
// Memory
// 43.9 MB
// Beats
// 38.27%
    public boolean isPalindrome(String s) {
        StringBuilder fromLeft = new StringBuilder();
        StringBuilder fromRight = new StringBuilder();
        String sc =s.toLowerCase() ;

        for(int c = 0 ; c < sc.length(); c++) {
            if((sc.charAt(c) >= '0' && sc.charAt(c) <='9') || (sc.charAt(c) >= 'a' && sc.charAt(c) <='z')) {
                fromLeft.append(sc.charAt(c)) ;
            }
        }   
        sc= fromLeft.toString() ;
        fromLeft.setLength(0) ;
        
        for(int c = 0 ; c < sc.length(); c++) {
            fromLeft.append(sc.charAt(c)) ;
            fromRight.append(sc.charAt(sc.length()-c-1)) ;
        }   
        // System.out.println(fromLeft.toString()) ;
        //         System.out.println(fromRight.toString()) ;
        return fromLeft.toString().equals(fromRight.toString()) ;
    }

    public boolean isPalindrome2(String s) {
        short len = (short)s.length();
        int left = 0;
        int right = len -1;
        while(left < right){
            char chl = s.charAt(left);
            char chr = s.charAt(right);

            if(!Character.isLetterOrDigit(chl)) left++;
            else if(!Character.isLetterOrDigit(chr)) right--;
            else if(Character.toLowerCase(chl) != Character.toLowerCase(chr)) return false;
            else {
                left++;
                right--;
            }
        }

        return true;
    }
}
