import java.util.Stack;

Runtime
Details
-ms
Beats 100.00%of users with Java
Memory
Details
39.92mb
Beats 98.72%of users with Java

class MyQueue {

    Stack<Integer> s1 ;
    Stack <Integer > s2 ;

    public MyQueue() {
        s1= new Stack() ;
        s2 = new Stack() ;
    }
    
    public void push(int x) {
        
        while(s1.isEmpty() == false ) {
            s2.push(s1.pop()) ;

        }
        s2.push(x) ;

        while(s2.isEmpty() == false ) {
            s1.push(s2.pop()) ;
        }
        
    }
    
    public int pop() {
        return s1.pop();
    }
    
    public int peek() {
        return s1.peek();
    }
    
    public boolean empty() {
        return s1.isEmpty() ;
    }
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * MyQueue obj = new MyQueue();
 * obj.push(x);
 * int param_2 = obj.pop();
 * int param_3 = obj.peek();
 * boolean param_4 = obj.empty();
 */