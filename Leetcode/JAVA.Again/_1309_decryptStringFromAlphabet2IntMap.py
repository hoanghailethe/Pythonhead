class Solution(object):
#     untime: 24 ms, faster than 73.58% of Python online submissions for Decrypt String from Alphabet to Integer Mapping.
# Memory Usage: 13.4 MB, less than 71.07% of Python online submissions
    def freqAlphabets(self, s):
        """
        :type s: str
        :rtype: str
        """
        alphabets= ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        # string_array = list(s)
        decrypt_string_array = []

        id = len(s) - 1

        while id >= 0 : 
            char_at_id = s[id]

            if char_at_id == '#' :
                id -= 2 
                str_number = s[id : id + 2]
                decrypt_string_array.insert(0, alphabets[ int(str_number) - 1] )
            else: 
                decrypt_string_array.insert(0, alphabets[ int(char_at_id) - 1] )
            id -= 1

        res = "".join(decrypt_string_array)
        return res