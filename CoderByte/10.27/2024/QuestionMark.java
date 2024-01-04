// https://coderbyte.com/editor/Questions%20Marks:Java

import java.util.*; 
import java.io.*;

class Main {

  public static boolean QuestionsMarks(String str) {
    char[] arr = str.toCharArray();
    int questMark = 0 ;  
    char preNum = 0 ;
    char afNum = 0 ;
    for(char a : arr) {
        // System.out.println( "a:" + a + " pre:" + preNum + " " + afNum ) ;
        if( isCharNum(a)==true && questMark<3 ) preNum = a; 
        else if(preNum!=0 && a =='?') questMark++; 
        else if(questMark == 3 && isCharNum(a) ) {
          afNum = a ;
          // System.out.println( "AFTER: a :" + a + " pre :" + preNum + " " + afNum ) ;
          if((afNum-'0' + preNum-'0' == 10)) return true ;
          else {
            preNum=a;
            afNum=0;
            questMark=0;
          }

        }
        
    }
    return false;
  }

  public static boolean isCharNum(char c) {
    // if ('0' <= c && c<= '9') System.out.println( c + " is Num") ;
    return '0' <= c && c<= '9';
  }

  public static void main (String[] args) {  
    // keep this function call here     
    Scanner s = new Scanner(System.in);
    System.out.print(QuestionsMarks(s.nextLine())); 
  }

}