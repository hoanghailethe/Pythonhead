class Solution:
    # Runtime: 32 ms, faster than 63.51% of Python3
    # Memory Usage: 14.3 MB, less than 57.63%
    def generate(self, numRows: int) -> List[List[int]]:
        res = []
        base_row = []
        for row_i in range(numRows):
            base_row.append(1)
            row_clone1 = base_row.copy()
            for cell_index in range(1, len(base_row)-1):
                base_row[cell_index] = row_clone1[cell_index-1] + row_clone1[cell_index]
            row_clone2 = base_row.copy()
            res.append(row_clone2)
        return res