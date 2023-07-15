import java.util.Queue;

public class ImplStackByQueue {
    
}

class MyStack {

    Queue<Integer> holder ;
    Queue<Integer> tempt  ;

    public MyStack() {
        holder = new LinkedList() ;
        tempt = new LinkedList() ;
    }
    
    public void push(int x) {
        while(holder.isEmpty() == false ){
            tempt.add(holder.poll()) ;
        }

        holder.add(x) ;
        while(tempt.isEmpty() == false ){
            holder.add(tempt.poll()) ;
        }
    }
    
    public int pop() {
        return holder.poll() ;
    }
    
    public int top() {
        return holder.peek() ;
        
    }
    
    public boolean empty() {
        return holder.isEmpty() ;
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

//  Runtime
// Details
// -ms
// Beats 100.00%of users with Java
// Memory
// Details
// 40.40mb
// Beats 66.94%of users with Java