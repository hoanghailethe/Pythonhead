public class 1678GoalParser {
    public String interpret(String command) {
        StringBuilder sb = new StringBuilder() ;

        String s = "" ;

        for(char c : command.toCharArray()) {
            if(c == 'G') sb.append(c);
            else s += c ;

            if(s.equals("()")) {
                sb.append('o');
                s="" ;
            }else if(s.equals("(al)")) {
                sb.append("al");
                s="" ;
            }
        }

        return sb.toString(); 

    }
}
