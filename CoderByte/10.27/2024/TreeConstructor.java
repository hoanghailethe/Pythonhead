import java.util.*; 
import java.io.*;

class Main {

  public static boolean TreeConstructor(String[] strArr) {
    // code goes here  
    // child 2 leter: <= 2 : 
    // parent 1 letter: 
    Map<Integer, TreeNodeInfo> m = new HashMap<Integer, TreeNodeInfo>() ;
    
    for(String s : strArr ) {
      int parent = s.charAt(1) - '0' ;
      int child = s.charAt(3) - '0' ;
      if(parent == child  ) return false ;

      if (m.containsKey(parent) == false ) {
        m.put( parent , new TreeNodeInfo ( 1 , 0) ) ; 
      } else  {
        TreeNodeInfo ifo = m.get(parent) ;
        if(ifo.addParent()>2) return false ;
      }

      if (m.containsKey(child) == false ) {
        m.put( child , new TreeNodeInfo ( 0 , 1) ) ; 
      } else  {
        TreeNodeInfo ifo = m.get(child) ;
        if(ifo.addChild()>2) return false ;
      }

    }

    return true;
  }

  public static void main (String[] args) {  
    // keep this function call here     
    Scanner s = new Scanner(System.in);
    System.out.print(TreeConstructor(s.nextLine())); 
  }

  public static class TreeNodeInfo {
    public int parentNode = 0; 
    public int childNode  = 0; 

    public TreeNodeInfo(int parentNode, int childNode) {
        parentNode=parentNode;
        childNode= childNode;
    }

    public int addParent() {
      parentNode++ ;
      return parentNode ;
    }
    public int addChild() {
      childNode++ ;
      return childNode ; 
    }
  }

  //FAIL

  public static boolean TreeConstructor2(String[] strArr) {
    // code goes here  
    // child 2 leter: <= 2 : 
    // parent 1 letter: 
    int [] parentCount = new int[128] ; 
    int [] childCount = new int [128] ; 

    
    for(String s : strArr ) {
      int parent = s.charAt(1) - '0' ;
      int child = s.charAt(3) - '0' ;
      if(parent == child  ) return false ;

      if(++parentCount[parent] > 2) return false ; 
      if(++childCount[child] > 2 ) return false ;

    }

    return true;
  }

  public static void main2 (String[] args) {  
    // keep this function call here     
    Scanner s = new Scanner(System.in);
    System.out.print(TreeConstructor2(s.nextLine())); 
  }

//   1. For input new String[] {"(2,5)", "(2,6)"} the output was incorrect. The correct output is false

// 2. For input new String[] {"(10,20)"} the output was incorrect. The correct output is true

// 3. For input new String[] {"(2,3)", "(1,2)", "(4,9)", "(9,3)", "(12,9)", "(6,4)"} the output was incorrect. The correct output is true

// 4. For input new String[] {"(2,3)", "(1,2)", "(4,9)", "(9,3)", "(12,9)", "(6,4)", "(1,9)"} the output was incorrect. The correct output is false

// 5. For input new String[] {"(5,6)", "(6,3)", "(2,3)", "(12,5)"} the output was incorrect. The correct output is true

// 6. For input new String[] {"(10,20)", "(20,50)"} the output was incorrect. The correct output is true

// passALL 
public static boolean TreeConstructor3(String[] strArr) {
    // code goes here  
    // child 2 leter: <= 2 : 
    // parent 1 letter: 
    int [] parentCount = new int[1000] ; 
    int [] childCount = new int [1000] ; 



    
    for(String s : strArr ) {

      String substr = s.substring(1, s.length() -1 ) ;
      String[] strCont = substr.split(",") ; 

      int parent = Integer.valueOf(strCont[1])  ;
      int child = Integer.valueOf(strCont[0] ) ;
      if(parent == child  ) return false ;
      // System.out.print("1");
      if(++parentCount[parent] > 2) return false ; 
      // System.out.print("2");;
      if(++childCount[child] > 2 ) return false ;
      // System.out.print("3");

    }

    int countHead = 0 ;
     
    for(int i = 0 ; i <  parentCount.length ; i++ ){
      if( parentCount[i] > 0 && childCount[ i ] == 0)  {
        countHead++ ;
        // System.out.print( i + " i |");
        // System.out.println( " parentCount[i] " + parentCount[i] );
        if(countHead > 1) return false ;
        
      }
    }

    return true;
  }
}