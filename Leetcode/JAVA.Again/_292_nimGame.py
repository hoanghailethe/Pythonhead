


class Solution:
    store = {0 : True , 1: True, 2: True}
    def canWinNim(self, n: int) -> bool:
        global store 

        if n <= 3 or store[n-1] == False or store[n-2] == False or store[n-3] == False:
            store[n] = True
            return True

        else :
            ans = not self.canWinNim(n-3) and not self.canWinNim(n-2) and not self.canWinNim(n-1)
            store[n] = ans
            return ans
