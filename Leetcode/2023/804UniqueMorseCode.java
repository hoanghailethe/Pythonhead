import java.util.Set;

class Solution {

    Set<String> codes = new HashSet<>() ;
    String[] codeTransMap = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."} ;

    public int uniqueMorseRepresentations(String[] words) {
        StringBuilder sb = new StringBuilder() ;
        for(String word : words ) {
            sb.setLength(0);
            for (char a   : word.toCharArray()) {
                sb.append(codeTransMap[a-'a']) ;
            }
            codes.add(sb.toString()) ;
        }
        return codes.size() ;
    }
}

Accepted
Editorial
Solution
Runtime
Details
2ms
Beats 90.10%of users with Java
Memory
Details
40.31MB
Beats 66.23%of users with Java