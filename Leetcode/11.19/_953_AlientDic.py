class Solution:
    # group: https://leetcodecontest.com/?fbclid=IwAR38Dxyx1ncOqDOi75TlRXH9Q8cSxpHDn5PW3xe4OCgj0WaSvOXkLVhgF3w#/contest/6191b72e31afb9fb9baddf1a
    # Runtime: 36 ms, faster than 71.13% of Python3
    # Memory Usage: 14.2 MB, less than 91.78% of Python3

    def isAlienSorted(self, words: List[str], order: str) -> bool:
        for id in range(len(words) - 1):
            word1 = words[id]
            word2 = words[id + 1]

            for w_id in range(min(len(word1), len(word2))):
                letter1 = word1[w_id]
                letter2 = word2[w_id]
                dif = order.index(letter1) - order.index(letter2)
                if dif == 0:
                    continue
                elif dif > 0:
                    # print(letter1)
                    # print(letter2)
                    return False
                else:
                    break
            if letter1 == letter2 and len(word2) < len(word1):
                return False
        return True


class Solution2:
    def isAlienSorted(self, words: List[str], order: str) -> bool:

        table = {}
        for i in range(len(order)):
            table[order[i]] = i

        for i in range(1, len(words)):
            first = words[i - 1]
            second = words[i]
            if not self.is_valid(first, second, table):
                return False
        return True

    def is_valid(self, first, second, table):
        length = min(len(first), len(second))
        for i in range(length):
            if table[first[i]] > table[second[i]]:
                return False
            elif table[first[i]] < table[second[i]]:
                return True
        return len(first) <= len(second)


class Solution3:
    def isAlienSorted(self, words: List[str], order: str) -> bool:
        words_size = len(words)
        preced = defaultdict(int, {
            ch: idx
            for idx, ch in enumerate(order)
        })

        for idx in range(1, words_size):
            word1, word2 = words[idx - 1], words[idx]
            len1, len2 = len(word1), len(word2)
            min_len = min(len1, len2)

            # [app, appa] -> ok
            # [appa, app] -> wrong
            if len1 > len2 and word1[:min_len] == word2[:min_len]:
                return False

            for jdx in range(min_len):
                if word1[jdx] != word2[jdx]:
                    if preced[word1[jdx]] > preced[word2[jdx]]:
                        return False
                    break

        return True