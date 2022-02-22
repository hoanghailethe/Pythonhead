// SQL : https://leetcode.com/problems/delete-duplicate-emails/

class Solution {
//     Runtime: 2 ms, faster than 68.85% of Java online submissions for Excel Sheet Column Number.
// Memory Usage: 43.3 MB, less than 6.25% of Java online submissions for Excel Sheet Column Number.
// Next challenges:
    public int titleToNumber(String columnTitle) {
        int res = 0;
        

        for ( int i = columnTitle.length()-1 ; i >= 0 ; i--) {
            res += convertToNumber( i , columnTitle.charAt(columnTitle.length()-1 - i));
        }

        return res;
    }

    public int convertToNumber (int indexOfChar , char character ) {
        return (int) Math.pow(26, indexOfChar) * (1 + character - 'A');
    }
}

class Solution2 {
    public int titleToNumber(String columnTitle) {
        if(columnTitle == null || columnTitle.length() == 0){
            return 0;
        }
        int multipier = 0, result = 0;
        for(int i = columnTitle.length() -1 ; i >= 0 ; i-- ){
            int val = columnTitle.charAt(i) - 'A'+1;
            result = (int) (val * Math.pow(26,multipier)) + result;
            multipier += 1;
            //System.out.println(val+"  result : "+result+"  multipier :"+multipier);
        }
        return result;
    }
}

// Draft idea solution:

// A -> 1 = 26^ 0 + 0
// B -> 2 = 26 ^0 + 1 == > 0 is  COL number,  1 is char Order
// C -> 3
// ...
// Z -> 26
// AA -> 27  = 26^1 + 26 * 0
// AB -> 28 
// ...


// map { A: 0, B: 1, ... }

// function int convertToNumber ( int indexOfChar , char character ) { 
// 	return Math.pow(26, indexOfChar ) * ( 1 + character - 'A' )
// } 

// int res = 0 ;
// for ( char Chara, ind in column ) { 
// 	res += convertToNumber ( ind, map.get ( Chara ) ) 

// }
// return res