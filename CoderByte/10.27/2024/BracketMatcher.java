import java.util.*; 
import java.io.*;

class Main {

  public static int BracketMatcher(String str) {
    // code goes here  
    // Stack st = new Stack() ;
    int count = 0 ;
    for(char a : str.toCharArray()  ) {
      if(a=='(') count++ ;
      else if(a==')') count-- ;
      if(count< 0) return 0 ;
    }

    return 1;
  }

  public static void main (String[] args) {  
    // keep this function call here     
    Scanner s = new Scanner(System.in);
    System.out.print(BracketMatcher(s.nextLine())); 
  }

}