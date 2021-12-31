class Solution:
    def calPoints(self, ops: List[str]) -> int:
        score = []
        for op in ops:
            if op == 'C':
                score.pop()
            elif op == 'D':
                last_num = score[len(score)-1] *2
                score.append(last_num)
            elif op == '+':
                last_num = score[len(score)-1]
                sec_last = score[len(score)-2]
                score.append(last_num + sec_last)
            else :
                score.append(int(op))
            # print(score)
        return sum(score)