public class 817ReverseOnlyLetter {
    public String reverseOnlyLetters(String s) {
        int b = 0;
        int e = s.length()  - 1 ;

        // StringBuilder sb= new StringBuilder() ;
        char[] ca = s.toCharArray() ;

        while(b < e ) {
            if(isCharLetter(ca[b])==false) b++ ;
            if(isCharLetter(ca[e])==false) e-- ;
            if(isCharLetter(ca[b])&&isCharLetter(ca[e])) {
                char temp = ca[b];
                ca[b] =ca[e];
                ca[e] =temp ;
                b++;e--;
            }
        }
        return new String(ca);
    }

    public boolean isCharLetter(char a) {
        return (a>='a'&&a<='z') || (a>='A'&&a<='Z');
    }

    Runtime
Details
0ms
Beats 100.00%of users with Java
Memory
Details
40.47MB
Beats 64.64%of users with Java


}
