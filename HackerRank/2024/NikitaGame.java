import java.io.*;
import java.math.*;
import java.security.*;
import java.text.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.*;
import java.util.regex.*;
import java.util.stream.*;
import static java.util.stream.Collectors.joining;
import static java.util.stream.Collectors.toList;
//NEED
import java.util.stream.IntStream;

class Result {

    /*
     * Complete the 'arraySplitting' function below.
     *
     * The function is expected to return an INTEGER.
     * The function accepts INTEGER_ARRAY arr as parameter.
     */

    public static int arraySplitting(List<Integer> arr) {
    // Write your code here
        long sum= arr.stream().mapToInt(i -> i.intValue()).sum();

        System.out.println("sum " + sum) ;

        return subArrSplit(arr , sum ) ;

    }
    
    //MAP TO LONG TO PREVENT OVERFLOW for int
    public class Result {

        public static int arraySplitting(List<Integer> arr) {
            long sum = arr.stream().mapToLong(Integer::intValue).sum();
            return subArrSplit(arr, sum);
        }
    
        public static int subArrSplit(List<Integer> ar, long sum) {
            // System.out.println("SUM1 : "  + sum );
            // System.out.println("arr : "  +  ar );
            if (ar.size() == 1 || sum % 2 != 0) return 0;
    
            int maxSplit = 0;
            long accSum = 0;
    
            for (int i = 0; i < ar.size(); i++) {
                accSum += ar.get(i);
                if (accSum == sum / 2) {
                    maxSplit = 1 + Math.max(
                            subArrSplit(ar.subList(0, i + 1), sum / 2),
                            subArrSplit(ar.subList(i + 1, ar.size()), sum / 2)
                    );
                    break;
                }
                if (accSum > sum / 2) break;
            }
    
            return maxSplit;
        }
    }

    public static int subArrSplit2(List<Integer> ar, int sum){
        if(ar.size() == 1|| sum%2 != 0) return 0; 

        int maxSplit = 0; 
        int accSum = 0;
        IntStream.range(0, ar.size())
            .forEach(
                i -> {
                    accSum+= ar.get(i);
                    if(accSum==sum/2) {
                        maxSplit = 1 + Math.max(
                            subArrSplit( ar.subList( 0, i+1 ) , sum/2 ) ,
                            subArrSplit( ar.subList( i+1, ar.size() ) , sum/2 ) 
                        ); 
                    }
                    // if( accSum > sum/2 ) return 0 ;
                    //cant return and break forEACH loop
                }
            );

        return maxSplit ; 

    }
}

public class Solution {
    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(System.getenv("OUTPUT_PATH")));

        int t = Integer.parseInt(bufferedReader.readLine().trim());

        IntStream.range(0, t).forEach(tItr -> {
            try {
                int arrCount = Integer.parseInt(bufferedReader.readLine().trim());

                List<Integer> arr = Stream.of(bufferedReader.readLine().replaceAll("\\s+$", "").split(" "))
                    .map(Integer::parseInt)
                    .collect(toList());

                int result = Result.arraySplitting(arr);

                bufferedWriter.write(String.valueOf(result));
                bufferedWriter.newLine();
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
        });

        bufferedReader.close();
        bufferedWriter.close();
    }
}

/*abstract TEST CASAE WRONG
Compiler Message
Wrong Answer
Input (stdin)
10
42
0 2 0 2 0 0 0 0 2 0 0 2 2 0 2 2 2 2 0 0 0 2 0 0 2 2 2 2 2 2 0 0 0 0 2 0 2 0 2 0 2 2
24
2 0 0 2 2 0 0 0 0 2 0 2 0 2 0 2 0 0 0 2 0 0 2 0
64
999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994 999999994
70
1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
103
4096 4096 1024 256 256 128 128 128 128 512 512 512 512 256 256 512 512 128 32 32 32 32 128 128 1024 1024 2048 512 512 1024 2048 2048 1024 512 512 2048 2048 2048 16384 16384 2048 256 128 128 512 256 256 512 2048 1024 1024 512 512 1024 1024 1024 2048 512 512 1024 4096 4096 4096 2048 2048 4096 2048 2048 2048 1024 512 256 16 16 32 64 128 2048 512 512 512 512 8192 8192 32768 32768 65536 16384 8192 4096 4096 16384 16384 32768 8192 8192 16384 65536 16384 16384 16384 8192 8192
77
2097152 1048576 1048576 2097152 1048576 262144 262144 524288 1048576 1048576 1048576 1048576 2097152 2097152 1048576 524288 524288 2097152 524288 524288 524288 524288 2097152 524288 262144 262144 524288 131072 131072 131072 131072 262144 65536 65536 32768 32768 65536 262144 262144 1048576 1048576 1048576 262144 262144 524288 524288 131072 65536 65536 32768 32768 65536 32768 32768 65536 2097152 2097152 131072 65536 65536 131072 131072 262144 65536 65536 131072 1048576 2097152 2097152 2097152 4194304 2097152 524288 524288 1048576 4194304 8388608
8
16384 8192 8192 16384 8192 8192 32768 32768
11
8760958 8760957 547560 547560 547560 273780 273780 2190239 4380479 4380479 4380478
15
21211 21211 21211 21211 21211 21211 21211 21211 21211 21211 21211 21211 21211 21211 21211
55
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Expected Output
0
0
6
2
15
11
4
1
0
54





*/