public class SockMechan {
    public static int sockMerchant(int n, List<Integer> ar) {
        // Write your code here
            Set<Integer> colorExs = new HashSet<>() ;
            int[] colors = new int[101] ;
            int pairC = 0 ;
            
            for(int colorCode : ar ) {
                colors[colorCode]++;
                colorExs.add(colorCode) ;   
            }
            
            for(int colorCode : colorExs) {
                pairC += colors[colorCode]/2 ;
            }
            return pairC ;
    
        }
}
