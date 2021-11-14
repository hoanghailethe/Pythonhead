from typing import List

# Runtime: 668 ms, faster than 47.20% of Python3
# Memory Usage: 17.3 MB, less than 13.64% of Python3
class Solution:
    def islandPerimeter(self, grid: List[List[int]]) -> int:
        # for dinf the first land then:
        founded_land = False
        perimeter = 0
        for id_row in range(len(grid)):
            row = grid[id_row]
            for id_col in range(len(row)):
                if row[id_col] == 0:
                    continue
                else:
                    perimeter = self.dfs(grid, id_row, id_col, 1)
                    founded_land = True
                    break
            if founded_land:
                break
        return perimeter

    def dfs(self, grid, id_row, id_col, perimeter):
        if id_row == len(grid) or id_row < 0 or id_col == len(grid[0]) or id_col < 0:
            return perimeter
        # not land, dont count
        if grid[id_row][id_col] == 0:
            return perimeter
        elif grid[id_row][id_col] == 1:
            grid[id_row][id_col] += 1
            perimeter += 3
            # update to know that we go through this
            perimeter = self.dfs(grid, id_row + 1, id_col, perimeter)
            perimeter = self.dfs(grid, id_row - 1, id_col, perimeter)
            perimeter = self.dfs(grid, id_row, id_col + 1, perimeter)
            perimeter = self.dfs(grid, id_row, id_col - 1, perimeter)
        else:
            # case == 2 mean this is the land connected to this cell, we eliminate the common by minus two
            perimeter -= 1
        return perimeter

# better and faster No need DFS:
    #  Runtime: 460 ms, faster than 95.97% of Python3
    def islandPerimeter2(self, grid):
        """
        :type grid: List[List[int]]
        :rtype: int
        """
        p = 0
        for i, rows in enumerate(grid):
            for j, column in enumerate(rows):
                if column == 1:
                    p += 4
                    if j != 0:
                        if grid[i][j - 1] == 1:
                            p -= 2
                    if i != 0:
                        if grid[i - 1][j] == 1:
                            p -= 2
        return p


# python DFS
    # Runtime: 648 ms, faster than 51.80% of Python3
    # Memory Usage: 29.2 MB, less than 5.00%
    def islandPerimeter3(self, grid: List[List[int]]) -> int:
        Rows = len(grid)
        Cols = len(grid[0])
        visited = set()
        per = 0

        def dfs(r, c):
            if r < 0 or r >= Rows or c < 0 or c >= Cols or grid[r][c] == 0:
                return 1

            if (r, c) in visited:
                return 0

            visited.add((r, c))

            per = dfs(r + 1, c)
            per += dfs(r - 1, c)
            per += dfs(r, c - 1)
            per += dfs(r, c + 1)

            return per

        for r in range(Rows):
            for c in range(Cols):
                if grid[r][c] == 1:
                    return dfs(r, c)
