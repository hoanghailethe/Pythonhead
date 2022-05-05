class Solution:
    def duplicateZeros(self, arr: List[int]) -> None:
        """
        Do not return anything, modify arr in-place instead.
        """
        for id in range(len(arr)) :
            if arr[id] == 0:
                arr.insert(id, 0)
                id += 1

    def duplicateZeros(self, arr: List[int]) -> None:
        index = 0
        while index < len(arr):
            if arr[index] == 0:
                index += 1
                arr.insert(index - 1, 0)
                arr.pop()
            index += 1

    