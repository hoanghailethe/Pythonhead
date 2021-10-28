

# 4 9 2
# 3 5 7
# 8 1 5

# 5 3 4
# 1 5 8
# 6 4 2

# https://www.hackerrank.com/challenges/magic-square-forming/problem?isFullScreen=true

# failed 18/25 test
def formingMagicSquare(s):
    # Write your code here
    TOTAL_SUM = 15
    row1Cost = abs(TOTAL_SUM - s[0][0] - s[0][1] - s[0][2])
    row2Cost = abs(TOTAL_SUM - s[1][0] - s[1][1] - s[1][2])
    row3Cost = abs(TOTAL_SUM - s[2][0] - s[2][1] - s[2][2])

    return row1Cost + row2Cost + row3Cost


class Magic(object):

    pre = [
            [[8, 1, 6], [3, 5, 7], [4, 9, 2]],
            [[6, 1, 8], [7, 5, 3], [2, 9, 4]],
            [[4, 9, 2], [3, 5, 7], [8, 1, 6]],
            [[2, 9, 4], [7, 5, 3], [6, 1, 8]],
            [[8, 3, 4], [1, 5, 9], [6, 7, 2]],
            [[4, 3, 8], [9, 5, 1], [2, 7, 6]],
            [[6, 7, 2], [1, 5, 9], [8, 3, 4]],
            [[2, 7, 6], [9, 5, 1], [4, 3, 8]],
            ]

    def evaluate(self, s):
        totals = []
        for p in self.pre:
            total = 0
            for p_row, s_row in zip(p, s):
                for i, j in zip(p_row, s_row):
                    if not i == j:
                        total += max([i, j]) - min([i, j])
            totals.append(total)
        return min(totals)


# JAVA
#
#     int cost[] = {0,0,0,0,0,0,0,0};
#     int t[][] =
#     {
#         {4,9,2,3,5,7,8,1,6},
#         {4,3,8,9,5,1,2,7,6},
#         {2,9,4,7,5,3,6,1,8},
#         {2,7,6,9,5,1,4,3,8},
#         {8,1,6,3,5,7,4,9,2},
#         {8,3,4,1,5,9,6,7,2},
#         {6,7,2,1,5,9,8,3,4},
#         {6,1,8,7,5,3,2,9,4},
#     };
#
#     for(int i=0;i<8;i++)
#     {
#     cost[i] = Math.abs(t[i][0]-s[0][0]) + Math.abs(t[i][1]-s[0][1]) + Math.abs(t[i][2]-s[0][2]);
#     cost[i] = cost[i] + Math.abs(t[i][3]-s[1][0]) + Math.abs(t[i][4]-s[1][1]) + Math.abs(t[i][5]-s[1][2]);
#     cost[i] = cost[i] + Math.abs(t[i][6]-s[2][0]) + Math.abs(t[i][7]-s[2][1]) + Math.abs(t[i][8]-s[2][2]);
#     }
#
#     Arrays.sort(cost);