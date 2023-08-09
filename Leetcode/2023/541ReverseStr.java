public class 541ReverseStr {
    public String reverseStr(String s, int k) {
        StringBuilder sb = new StringBuilder()  ;

        if(s.length() < 2*k ) {
            sb.append(s);
            sb.reverse() ;
            
        }else {
            sb.append(s.substring(0,k));
            sb.reverse();
            sb.append(s.substring(k));
        }
        return sb.toString() ;

    }
}
