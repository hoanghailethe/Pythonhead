class Solution {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        if(n==0 ) return ;
        int num2Size = nums2.length ;
        int num1Size = nums1.length - num2Size ;

        // int runC = 0 ;
        // for(int i = 0 ; i < num1Size ; i++ ) {
        //     if(nums1[i] > nums2[runC]) {
        //         int tempt = nums1[i] ;
        //         nums1[i] = nums2[runC] ;
        //         nums2[runC] = tempt ;
        //         runC++ ;
        //     }
        // }

        for (int i =num1Size; i < nums1.length ; i++  ) {
            nums1[i] = nums2[i - num1Size] ;
        }
        Arrays.sort(nums1);
    }

    //Merge Sort apply
    public void merge2(int[] nums1, int m, int[] nums2, int n) {
        if(n==0 ) return ;
        int num2Size = nums2.length ;
        int num1Size = nums1.length - num2Size ;
        for (int i =num1Size; i < nums1.length ; i++  ) {
            nums1[i] = nums2[i - num1Size] ;
        }

        // start merge sort

        mergeSort(nums1) ;

    }
    public void mergeSort(int[] nums1) {

        if (nums1.length == 1) return ;

        int mid = nums1.length /2 ;

        int[] haftLeft = Arrays.copyOfRange(nums1, 0, mid) ;
        int[] haftRight = Arrays.copyOfRange(nums1, mid, nums1.length) ;
        mergeSort(haftLeft) ;
        mergeSort(haftRight) ;

        nums1= merge(haftLeft , haftRight ) ;


    }

    public int[] merge(int[] part1, int[] part2) {
        int[] sumArr = new int[part1.length + part2.length] ;
        int a = 0;
        int b = 0;

        for(int i = 0 ; i < sumArr.length ; i++) {
            if (a == part1.length ) {
                sumArr[i] = part2[b]; 
            }
            else if (b == part2.length ) {
                sumArr[i] = part1[a]; 
            }
            else if(part1[a] >= part2[b] ) {
                sumArr[i] = part1[a]; 
                a++ ;
            } else {
                sumArr[i] = part2[b];
                b++;
            }
        }
        return sumArr ;
    }

    public void merge(int[] nums1, int m, int[] nums2, int n) {
        //variables to work as pointers
        int i=m-1; // will point at m-1 index of nums1 array
        int j=n-1; // will point at n-1 index of nums2 array
        int k=nums1.length-1; //will point at the last position of the nums1 array

        // Now traversing the nums2 array
        while(j>=0){
            // If element at i index of nums1 > element at j index of nums2
            // then it is largest among two arrays and will be stored at k position of nums1
            // using i>=0 to make sure we have elements to compare in nums1 array
            if(i>=0 && nums1[i]>nums2[j]){
                nums1[k]=nums1[i];
                k--; 
                i--; //updating pointer for further comparisons
            }else{
                // element at j index of nums2 array is greater than the element at i index of nums1 array 
                // or there is no element left to compare with the nums1 array 
                // and we just have to push the elements of nums2 array in the nums1 array.
                nums1[k] = nums2[j];
                k--; 
                j--; //updating pointer for further comparisons
            }
        }
    }
}
    