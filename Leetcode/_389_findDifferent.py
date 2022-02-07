from re import A


class Solution:
    # Runtime: 82 ms, faster than 5.26% of Python3 o
    # Memory Usage: 13.9 MB, less than 88.02%
    def findTheDifference(self, s: str, t: str) -> str:
        store = {}
        for a in s:
            store[a] = store.get(a, 0) + 1
        for a in t:
            if a not in store or store.get(a) == 0:
                return a 
            else:
                store[a] = store.get(a) - 1
        return 0