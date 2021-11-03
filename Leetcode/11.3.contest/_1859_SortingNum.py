=
class Solution:
    def sortSentence(self, s: str) -> str:
        list_s = s.split()
        result = [""] * len(list_s)
        for word in list_s:
            index = int(word[-1]) - 1
            only_word = len(word) - 1
            result[index] = word[0:only_word]
        return " ".join(result)