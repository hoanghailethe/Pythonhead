class Solution:
    # DEEP COPY : https://www.delftstack.com/howto/python/deep-copy-list-in-python/
    # Runtime: 912 ms, faster than 16.78% of Python3
    # Memory Usage: 14.8 MB, less than 82.05% of Python3
    def imageSmoother(self, img: List[List[int]]) -> List[List[int]]:
        numRows = len(img)
        numCols = len(img[0])
        img_clone = copy.deepcopy(img)
        for ir in range(numRows):
            rowVals = img[ir]
            for ic in range(numCols):
                rowVals[ic] = int(self.AvgSmoothVal(ir, ic, img_clone))
        return img

    def AvgSmoothVal(self, ir: int, ic: int, img: List[List[int]]) -> int:
        sum = 0
        count = 0
        for addRow in range(-1, 2):
            for addCol in range(-1, 2):
                if len(img) > ir + addRow >= 0 and 0 <= ic + addCol < len(img[0]):
                    sum += img[ir + addRow][ic + addCol]
                    count += 1
        # if 149 > sum/count > 147.0:
        #     print(sum)
        #     print(count)
        return sum / count