# er: variable name global not defined

class Solution(object):
    def uniquePathsWithObstacles(self, obstacleGrid):
        """
        :type obstacleGrid: List[List[int]]
        :rtype: int
        """
        patho = 0 
        n = len(obstacleGrid) - 1
        m = len(obstacleGrid[0]) - 1
        
        def findNextMove(x, y, patho):
            # global patho
            if y > m or x > n :
                return
            print('x ' + str(x))
            print ('y ' + str(y))
            if obstacleGrid[x][y] == 1:
                return
            if y == m and x == n :
                # global patho
                patho += 1
                print(patho)
            else:
                # global patho
                findNextMove(x+1, y, patho)
                findNextMove(x, y + 1, patho)
        findNextMove(0,0, patho)
        
        return patho
        