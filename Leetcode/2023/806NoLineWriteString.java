public class 806NoLineWriteString {
    public int[] numberOfLines(int[] widths, String s) {
        int[]res = new int[2] ;
        final int WIDTH_PER_LINE = 100 ;

        int line = 1 ;
        int widthCurLine = 0 ;

        for(char a : s.toCharArray()) {
            widthCurLine+=widths [a-'a'];
            if(widthCurLine>WIDTH_PER_LINE) {
                line++ ;
                widthCurLine = widths [a-'a'] ;
            }
        }
        res[0] = line;
        res[1] = widthCurLine;
        
        return res ;


    }
}

0ms
Beats 100.00%of users with Java
Memory
Details
40.43MB
Beats 70.07%of users with Java

