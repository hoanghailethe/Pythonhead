# Runtime: 1838 ms, faster than 11.83% of Python3 online submissions for Design HashSet.
# Memory Usage: 18.6 MB, less than 80.28% of Python3 online submissions for Design HashSet.

class MyHashSet:
    store =[]

    def __init__(self):
        global store 
        store = [] 

    def add(self, key: int) -> None:
        if not self.contains(key):
            store.append(key)

    def remove(self, key: int) -> None:
        if self.contains(key):
            store.remove(key)
        
    def contains(self, key: int) -> bool:
        return key in store


# Your MyHashSet object will be instantiated and called as such:
# obj = MyHashSet()
# obj.add(key)
# obj.remove(key)
# param_3 = obj.contains(key)