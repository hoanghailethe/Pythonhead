public class 520DectectCapital {
    public boolean detectCapitalUse(String word) {
        if("".equals(word))return true ;

        if(word.length()>1 ){
            if(isCapital(word.charAt(0)) ==false && isCapital(word.charAt(1)) ==true )return false ;
        }

        for(int i = 1 ; i< word.length() -1 ; i ++) {
            if(isCapital(word.charAt(i))!= isCapital(word.charAt(i+1))) {
                return false;
            }
        }

        return true ;
    }

    public boolean isCapital(char a) {
        return a>= 'A'&& a<='Z';
    }
//     Runtime
// Details
// -ms
// Beats 100.00%of users with Java
// Memory
// Details
// 40.57mb
// Beats 94.99%of users with Java
}
