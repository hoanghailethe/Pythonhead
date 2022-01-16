class Solution:
    # Runtime: 308 ms, faster than 40.75% of Python3
    # Memory Usage: 15.7 MB, less than 32.50% 
    def findShortestSubArray(self, nums: List[int]) -> int:
        maxAppear = 0 
        frequence = {}

        # numsAppearMost = []
        shortestSubLeng = 99999999

        for idx, val in enumerate(nums, start = 0):
            # first is the begin Idxm seccond is the last index, third is the time appear
            timeAppear = frequence.get(val, [-1, 0, 1]) 
            if timeAppear[0] == -1:
                timeAppear[0] = idx
            else:
                timeAppear[1] = idx
                timeAppear[2] += 1

            if timeAppear[2] >= maxAppear:
                if timeAppear[2] > maxAppear:
                    maxAppear = timeAppear[2]
                    shortestSubLeng = 99999999

                dif = idx - timeAppear[0] + 1
                # print(dif)
                if dif < shortestSubLeng:
                    shortestSubLeng = dif
            frequence[val] = timeAppear

        return shortestSubLeng