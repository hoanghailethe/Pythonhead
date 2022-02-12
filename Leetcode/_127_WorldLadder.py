class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: List[str]) -> int:
        
        next_begin_words = [beginWord]
        stepCount = 0

        def is_dif_one_char( a: str, b:str) -> bool:
            if a == b or len(a) != len(b): 
                return False
            else:
                length = len (a)
                dif_number = 0
                for i in range(length): 
                    if a[i] != b[i]:
                        dif_number += 1 
                    if dif_number == 2: return False
                return dif_number == 1

        while next_begin_words:
            for thisWord in next_begin_words :
                stepCount += 1
                saved_word = []
                # print(saved_word)
                for nextWord in wordList:
                    if is_dif_one_char( nextWord, thisWord ):
                        if nextWord == endWord: return stepCount
                        else: saved_word.append(nextWord)
                # print(saved_word)
                next_begin_words = saved_word
                wordList = [x for x in wordList if (x not in saved_word)]
                # print(next_begin_words)
                # print(wordList)
        return 0
