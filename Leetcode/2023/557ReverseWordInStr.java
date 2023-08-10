public class 557ReverseWordInStr {
    public String reverseWords(String s) {
        String[] wordsArr = s.split(" ") ;

        StringBuilder sb = new StringBuilder() ;

        for(int i =0 ;i <wordsArr.length ; i++) {
            sb.append(wordsArr[i]) ;
            sb.reverse() ;

            wordsArr[i] =sb.toString() ;
            sb.setLength(0) ;
        }

        String res =  String.join(" ", wordsArr);

        return res ;
    }

//     5ms
// Beats 82.00%of users with Java
// Memory
// Details
// 44.22mb
// Beats 71.02%of users with Java
}
