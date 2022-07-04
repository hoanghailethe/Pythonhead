public class _1189_MaxNumBaloon {

//     Runtime: 3 ms, faster than 71.45% of Java online submissions for Maximum Number of Balloons.
// Memory Usage: 42.5 MB, less than 51.00% of Java online submissions for Maximum Number of Balloons.
// Next challenges:
    public int maxNumberOfBalloons(String text) {
        String targetWord = "balloon";

        int [] count = new int[5];

        for(char word : text.toCharArray() ) {
            if(word == 'b') {
                count[0]++;
            } else if(word == 'a') {
                count[1]++;
            } else if(word == 'l') {
                count[2]++;
            } else if(word == 'o') {
                count[3]++;
            } else if(word == 'n') {
                count[4]++;
            }
        }

        count[2] = count[2] / 2 ;
        count[3] = count[3] / 2 ;

        int maxBallon = Integer.MAX_VALUE ;
        for(int countWord : count ) {
            maxBallon = Math.min(maxBallon, countWord) ; 
        }
        return maxBallon ;
    }
}
