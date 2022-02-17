class Solution {

//     Runtime: 1 ms, faster than 77.49% of Java online submissions for Flood Fill.
// Memory Usage: 48.8 MB, less than 6.63% of Java online submissions for Flood Fill.
    public int[][] floodFill(int[][] image, int sr, int sc, int newColor) {
        int oldColor = image[sr][sc];
        if(oldColor != newColor ) BFS( image, sr, sc, oldColor, newColor);
        return image;
    }

    public void BFS(int[][] image, int sr, int sc, int oldColor, int newColor) {

        if( sr < 0 || sr >= image.length || sc <0 || sc >= image[0].length ) {
            return;
        }

        if (image[sr][sc] != oldColor) return;

        image[sr][sc] = newColor;
        BFS(image, sr - 1, sc , oldColor, newColor);
        BFS(image, sr , sc - 1, oldColor, newColor);
        BFS(image, sr, sc + 1, oldColor, newColor);
        BFS(image, sr + 1, sc, oldColor, newColor);
    
    }
}

class Solution2 {
    public int[][] floodFill(int[][] image, int sr, int sc, int newColor) {
        if(image==null || image.length==0)
            return image;
        
        if (image[sr][sc] == newColor) return image;
        
        int oldColor=image[sr][sc];
        dfs(image,sr,sc,oldColor,newColor);
        return image;
    }
    
    public void dfs(int[][] image, int sr, int sc, int oldColor,int newColor){
        
        
        if(sr<0 || sc<0 || sr>=image.length||sc>=image[0].length){
            return;
        }
        
        if(image[sr][sc]!=oldColor)
            return;
        
        image[sr][sc]=newColor;
        dfs(image,sr+1,sc,oldColor,newColor);   
        dfs(image,sr-1,sc,oldColor,newColor);   
        dfs(image,sr,sc-1,oldColor,newColor);   
        dfs(image,sr,sc+1,oldColor,newColor);   
    }
}