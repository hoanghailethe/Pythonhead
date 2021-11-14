from typing import List


class Solution:

# https://stackoverflow.com/questions/17268958/finding-occurrences-of-a-word-in-a-string-in-python-3
# Runtime: 20 ms, faster than 99.08% of Python3
# Memory Usage: 14.4 MB, less than 24.39% of Python3

    def uncommonFromSentences(self, s1: str, s2: str) -> List[str]:
        res = []
        words_s1 = s1.split()
        words_s2 = s2.split()

        for word in words_s1:
            # print(word + ' : ' + str(s1.count(word)))
            if words_s1.count(word) == 1 and (' ' + word + ' ') not in (' ' + s2 + ' '):
                res.append(word)

        for word in words_s2:
            if words_s2.count(word) == 1 and (' ' + word + ' ') not in (' ' + s1 + ' '):
                res.append(word)

        return res
