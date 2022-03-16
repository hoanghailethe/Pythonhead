import java.util.HashMap;
import java.util.Iterator;

public class _914_XofaKind {
// Runtime: 15 ms, faster than 28.31% of Java online submissions for X of a Kind in a Deck of Cards.
// Memory Usage: 53.1 MB, less than 11.76% of Java online submissions for X of a Kind in a Deck of Cards.

    public boolean hasGroupsSizeX(int[] deck) {
        
        HashMap<Integer, Integer> storeCount = new HashMap<>();

        for (int card : deck) {
            storeCount.put(card, storeCount.getOrDefault(card, 0) + 1) ;
        }

        return hasUCNN(storeCount);
    }

    public boolean hasUCNN(HashMap<Integer, Integer> storeCount) {
        int[] primeNumber = {2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197};

        boolean hasUCNN = true;
        for (int num : primeNumber) {
            Iterator<Integer> iterator = storeCount.keySet().iterator() ;
            boolean notDivisable = false;
            while(iterator.hasNext()) {
                int cardCount = storeCount.get(iterator.next());
                if (cardCount % num != 0) {
                    notDivisable = true;
                    break;
                }
            }
            if (notDivisable) {
                hasUCNN = false;
                continue;
            } else {hasUCNN = true;break;}
        }
        return hasUCNN;
    }
}

class Solution2 {
    public boolean hasGroupsSizeX(int[] deck) {
        Map<Integer, Integer> numCount = new HashMap<Integer,Integer>();
        for(int num : deck){
            numCount.put(num, numCount.getOrDefault(num, 0) + 1 );
        }
        int res = numCount.get(deck[0]);
        for(int val : numCount.values()){
            res = gcd(res, val);
            if(res == 1) 
                return false;
        }
        return true;   
    }

    private int gcd(int a, int b){
        if(a % b == 0) 
            return b;
        return gcd(b, a % b); 
    }
}
// Input
// [1,1,1,1,2,2,2,2,2,2]
// Output
// false
// Expected
// true