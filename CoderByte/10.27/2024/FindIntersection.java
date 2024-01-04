import java.util.*; 
import java.io.*;

class Main {

  public static String FindIntersection(String[] strArr) {
    // code goes here  
    String f = strArr[0] ;
    String l = strArr[1] ;

    Set check  = new HashSet() ;

    for( String c : f.split(", ") ) {
      check.add(c) ;
    } 
    StringBuilder sb = new StringBuilder() ;
    for(String c : l.split(", ") ) {
      if( check.contains(c) ) {
        sb.append(c);
        sb.append(",");
      }
    }
    sb.setLength(sb.length()-1) ;

    return sb.toString() ;
  }

  public static void main (String[] args) {  
    // keep this function call here     
    Scanner s = new Scanner(System.in);
    System.out.print(FindIntersection(s.nextLine())); 
  }

}