public class 374GuessNumberHigherLow {
    public int guessNumber(int n) {

               
        int b = 1 ;
        int e = n ;
        // int mid =  (1 + n ) / 2 ;

        while (b<=e) {
            int mid =  (b+e ) / 2 ;
            int checkCode = guess(mid) ; 
            if (checkCode==0){
                return mid ;
            }
            else if (checkCode == -1){
                e=mid -1;
            } else if (checkCode == 1) {
                b=mid +1;
            } else {
                System.out.print("err case" ); break ;
            }
        }
        return -1 ;
 
    }


//     Time Limit Exceeded
// 14 / 25 testcases passed
// Last Executed Input
// Use Testcase
// 2126753390
// 1702766719

    public int guessNumber(int n) {
        int i=1;
        int j=n;
        while(i<j){ // giong cach cua minh nhung bi overflow
            int mid = i + (j - i) / 2;
            if(guess(mid)==0){
                return mid;  
            }
            else if(guess(mid)==1){
                i=mid+1;
            }
            else{
                j=mid;
            }
        }
        return i;
    }
}
