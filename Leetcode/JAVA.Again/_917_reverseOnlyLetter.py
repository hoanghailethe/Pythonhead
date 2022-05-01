class Solution:
    def reverseOnlyLetters(self, s: str) -> str:
        size = len(s)
        begin = 0
        end = size -1 
        alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u','v', 'w', 'x', 'y', 'z']
         
        def isInAlphabet(a: str) -> bool:
            return a.lower in alpha

        def swapLetter(i:int, j:int):
            a= s[i]
            b=s[j]
            if a !=b:
                s= s[:i] + b + s[i+1:j-1] + a+ s[j:]

        while begin < end :
            while isInAlphabet(s[begin]) is False:
                begin += 1
            while isInAlphabet(s[end]) is False:
                end -= 1
            if begin < end :
                swapLetter(begin, end)
                begin += 1
                end -= 1