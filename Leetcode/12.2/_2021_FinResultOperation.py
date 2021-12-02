class Solution:
    # Runtime: 48 ms, faster than 87.99% of Python3
    def finalValueAfterOperations(self, operations: List[str]) -> int:
        a = operations.count("++X") + operations.count("X++") - operations.count("--X") - operations.count("X--")
        return a