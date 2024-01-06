import java.util.*; 
import java.io.*;

class Main {

  public static int BracketCombinations(int num) {
    // code goes here  
    if(num == 1) return 1; 
    if(num ==2) return 2; 

    return 2+ 2* (BracketCombinations(num-1)-1) + BracketCombinations(num-2) ;

  }

  public static void main (String[] args) {  
    // keep this function call here     
    Scanner s = new Scanner(System.in);
    System.out.print(BracketCombinations(s.nextLine())); 
  }

}

1. For input 0 the output was incorrect. The correct output is 1

2. For input 4 the output was incorrect. The correct output is 14

3. For input 5 the output was incorrect. The correct output is 42

4. For input 6 the output was incorrect. The correct output is 132

5. For input 7 the output was incorrect. The correct output is 429

6. For input 8 the output was incorrect. The correct output is 1430

7. For input 9 the output was incorrect. The correct output is 4862