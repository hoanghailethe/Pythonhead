import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Queue;

// Runtime: 0 ms, faster than 100.00% of Java online submissions for Implement Stack using Queues.
// Memory Usage: 41.6 MB, less than 41.67% of Java online submissions for Implement Stack using Queues.
public class _225_OneStackBy2Queues {
    Queue<Integer> queue1;

    public MyStack() {
        queue1 = new ArrayDeque<>();

    }
    
    public void push(int x) {
        queue1.add(x);
    }
    
    public int pop() {
        Queue<Integer> queue2 = new ArrayDeque<>();

        while ( queue1.size() > 1) {
            queue2.add( queue1.poll() );
        }

        int res = queue1.poll();
        queue1 = queue2;

        return res;
        
    }
    
    public int top() {
        Queue<Integer> queue2 = new ArrayDeque<>();

        while ( queue1.size() > 1) {
            queue2.add( queue1.poll() );
        }

        int res = queue1.poll();
        queue1 = queue2;
        queue2.add(res);

        return res;
    }
    
    public boolean empty() {
        return queue1.isEmpty();
    }
}

/**
 * Your MyStack object will be instantiated and called as such:
 * MyStack obj = new MyStack();
 * obj.push(x);
 * int param_2 = obj.pop();
 * int param_3 = obj.top();
 * boolean param_4 = obj.empty();
 */

