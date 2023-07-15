class Solution {
    int[] chars = new int [125] ;
    public int titleToNumber(String columnTitle) {
        for(char i = 'A' ; i <= 'Z' ;i++) {
            chars[i] = i - 'A' + 1 ;
        }

        for(char a : columnTitle) {
            
        }
    }
}