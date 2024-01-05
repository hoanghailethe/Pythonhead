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