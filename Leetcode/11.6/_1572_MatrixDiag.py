class Solution:
    # Runtime: 108 ms, faster than 72.14% of Python3
    # Memory Usage: 14.4 MB, less than 92.82% of Python3
    def diagonalSum(self, mat: List[List[int]]) -> int:
        sum = 0
        col = 0
        for row in mat:
            sum += row[col]
            reverse_index = len(row) - 1 - col
            if reverse_index != col:
                sum += row[reverse_index]
            col += 1
        return sum
