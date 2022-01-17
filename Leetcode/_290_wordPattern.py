class Solution:
    # Runtime: 27 ms, faster than 85.81% of Python3 online submissions for Word Pattern.
    # Memory Usage: 14.2 MB, less than 80.26%
    def wordPattern(self, pattern: str, s: str) -> bool:
        dictionary = {}
        takenVal = set()
        arrayWords = s.split()

        if len(pattern) != len(arrayWords):
            return False

        for id, val in enumerate(pattern):
            if not dictionary.get(val):
                if arrayWords[id] in takenVal:
                    return False
                dictionary[val] = arrayWords[id]
                takenVal.add(arrayWords[id])
            else:
                if dictionary[val] != arrayWords[id]:
                    return False
        return True