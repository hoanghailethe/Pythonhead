import java.util.ArrayList;

public class _133_cloneGraph {
    Node[] clonedNodeStore = new Node[101];

    public Node cloneGraph(Node node) {
        // clonedNodeStore
        return deepCloneTheNode(node);
    }   

    public Node deepCloneTheNode (Node node ) {
        Node newRootNode = new Node(node.val);
        clonedNodeStore[newRootNode.val - 1] = newRootNode  ;

        for( Node nodeNeighbor : node.neighbors) {
            if (nodeNeighbor.val > node.val) {
                Node newNeighborNode = deepCloneTheNode(nodeNeighbor);
                newRootNode.neighbors.add(newNeighborNode);
            } else { // this case mean Node existed, already created and stored in the store
                newRootNode.neighbors.add( clonedNodeStore[nodeNeighbor.val -1] );
            }
            
        }
        
        return newRootNode;
    }
}

class Node {
    public int val;
    public List<Node> neighbors;
    public Node() {
        val = 0;
        neighbors = new ArrayList<Node>();
    }
    public Node(int _val) {
        val = _val;
        neighbors = new ArrayList<Node>();
    }
    public Node(int _val, ArrayList<Node> _neighbors) {
        val = _val;
        neighbors = _neighbors;
    }
}
 