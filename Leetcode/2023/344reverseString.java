public class 344reverseString {

    public void reverseString(char[] s) {
        for(int i =0 , j = s.length -1 ; i < j ; i++, j--) {

            char tempt = s[i] ;
            s[i] = s[j] ;
            s[j] = tempt ;
        }
        
    }

    Runtime
Details
-ms
Beats 100.00%of users with Java
Memory
Details
51.08mb
Beats 32.73%of users with Java


}
