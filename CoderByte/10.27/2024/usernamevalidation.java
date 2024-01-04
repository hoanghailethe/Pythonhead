import java.util.*; 
import java.io.*;

class Main {

  public static boolean CodelandUsernameValidation(String str) {
    // code goes here 
    if(!(str.length() >= 4 &&  str.length() <=25) ) return false ;

    char firstLetter = str.charAt(0) ; 
    if(!isLetter(firstLetter)) return false ; 

    char lastLetter = str.charAt( str.length() -1 ) ;
    if( lastLetter == '_') return false ; 

    for(char a : str.toCharArray()) {
      if( !isLetter(a) && !isNumber(a)  && a != '_' ) return false ;
    }

    return true;
  }

  public static boolean isLetter(char firstLetter ) {
     return ( firstLetter >= 'a' && firstLetter <='z' ) || ( firstLetter >= 'A' && firstLetter <='Z' ) ;
  } 

  public static boolean isNumber(char firstLetter ) {
      return ( firstLetter >= '0' && firstLetter <='9' ) ;
    } 


  public static void main (String[] args) {  
    // keep this function call here     
    Scanner s = new Scanner(System.in);
    System.out.print(CodelandUsernameValidation(s.nextLine())); 
  }

}