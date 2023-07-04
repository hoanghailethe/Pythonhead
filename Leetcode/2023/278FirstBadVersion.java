/* The isBadVersion API is defined in the parent class VersionControl.
      boolean isBadVersion(int version); */

public class Solution extends VersionControl {

    public int firstBadVersion(int n) {
        if(isBadVersion(1)) return 1;
        if(isBadVersion(n)&& !isBadVersion(n-1)) return n ;
        
        int r = n ;
        int l = 1 ;
        
        int m = 0 ;

        while ( l< r) {
            m = (r+ l )  / 2 ;
            if (isBadVersion (m )) {
                if (!isBadVersion(m-1)) return m ;

                r = m -1;

            }  else {
                l = m ;
            }

        }
        
        return m ;
    }

        // Time Limit Exceeded
        // 11 / 24 testcases passed
        // Last Executed Input
        // Use Testcase
        // 2126753390
        // 1702766719

        public int firstBadVersion(int n) {
        int start = 0;
        int end = n;
        int mid = 0;
        while(start<end)
        {
            if(start==end) break;
            mid = start + (end - start)/2 ;
            if(isBadVersion(mid)) end = mid;
            else start = mid+1;
        }
        return end;
        
        
    }
}