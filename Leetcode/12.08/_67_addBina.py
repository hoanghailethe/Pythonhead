class Solution:
    # Runtime: 60 ms, faster than 7.34% of Python3
    def addBinary(self, a: str, b: str) -> str:
        temp_res = int(a, base=2) + int(b, base=2)
        temp_res = bin(temp_res)
        return str(temp_res)[2:]

    def addBinary2(self, a: str, b: str) -> str:
        x, y = int(a, 2), int(b, 2)
        while y:
            x, y = x ^ y, (x & y) << 1
        return bin(x)[2:]

# Runtime: 37 ms, faster than 34.59% of Python3 
    def addBinary3(self, a: str, b: str) -> str:
        return bin(int(a,2) + int(b,2))[2:]