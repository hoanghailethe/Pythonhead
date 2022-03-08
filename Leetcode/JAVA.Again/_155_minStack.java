import java.util.ArrayList;
import java.util.List;

public class _155_minStack {
//     Runtime: 1055 ms, faster than 5.01% of Java online submissions for Min Stack.
// Memory Usage: 49.6 MB, less than 5.60% of Java online submissions for Min Stack.
    class MinStack {
        List<Integer> store; 
        public MinStack() {
            store = new ArrayList<>();
        }
        
        public void push(int val) {
            store.add(store.size() -1, val);
        }
        
        public void pop() {
            store = store.subList(0, store.size()-1);
        }
        
        public int top() {
            return store.get(store.size() -1);
        }   
        
        public int getMin() {
            Integer min= Integer.MAX_VALUE;
            for (int num : store) {
                if (min > num) min = num;
            }
            // store.remove(min);
            return min;
        }
    }
    
}
