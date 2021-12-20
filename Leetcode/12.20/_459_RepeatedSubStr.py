class Solution:
    # Runtime: 252 ms, faster than 18.40% of Python3
    def repeatedSubstringPattern(self, s: str) -> bool:
        if len(s) < 2:
            return False
        end = 0
        while end < len(s)/2:
            sub_str_turn = s[:end+1]
            sub_str_turn_len = len(sub_str_turn)
            # print(sub_str_turn)
            begin_turn = 0
            while begin_turn < len(s):
                # print(s[begin_turn: begin_turn+sub_str_turn_len])
                if s[begin_turn: begin_turn+sub_str_turn_len] != sub_str_turn:
                    break
                begin_turn += sub_str_turn_len
            if begin_turn == len(s):
                return True
            # print(begin_turn)
            end += 1
        return False