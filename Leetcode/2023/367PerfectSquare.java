public class 367PerfectSquare {
    public boolean isPerfectSquare(int num) {
        int b = 1 ;
        int e = num ;

        while ( b < e ) {
            int mid = ( 1 + e ) / 2 ;
            System.out.println(b+ " "+ e+ " " +mid) ;
            int sqm = mid*mid ;
            System.out.println(sqm +" + num :  "+ num ) ;
             System.out.println(sqm == num) ;

            if(sqm == num) {
                return true;
            }else if( sqm < num) {
                b = mid ;
            } else {
                e = mid ;
            }
        }
        return false; 
    }
}

// bool isPerfectSquare(int num) {
//         int start=0;
//         if(num==1) return true;
//         int end=num/2;
//         while(start<=end)
//         {
//             long long int  mid=start+(end-start)/2;
            
//                 if(mid*mid==num) return true;
//                 else if(mid*mid<num) start=mid+1;
//                 else end=mid-1;
            
//         }
//         return false;
//     }