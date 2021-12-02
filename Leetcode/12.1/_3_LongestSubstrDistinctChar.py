class Solution:

    def lengthOfLongestSubstring(self, s: str) -> int:
        set_check = set()
        maxlen = 0
        slen = len(s)
        curlen = 0
        for ind in range(slen):
            c = s[ind]

            if c in set_check:
                maxlen = max(maxlen, len(set_check))
                # check if there is duplicated in the double back of the maxlen
                #exp: a	b	c	d	e	f
					# a	b	c	a	a	d	f
	                   #c	b	a	d	f
                if ind + curlen < slen:
                    if c not in s[ind+1: ind + curlen]:
                        # print(c)
                        # print(s[ind + 1: ind + curlen])
                        set_check.clear()
                        set_check.add(c)
                        curlen = 1

            else:
                set_check.add(c)
                curlen += 1
        maxlen = max(maxlen, len(set_check))
        return maxlen

# https://leetcode.com/problems/longest-substring-without-repeating-characters/discuss/1604670/PYTHON-44ms-98.96-FASTER-TWO-POINTER-%2B-SET
    def lengthOfLongestSubstring(self, s: str) -> int:
        # Happy case
        if not s:
            return 0

        # Initialize set with first element

        long_sub = set(s[0])
        max_length = 1
        length = 1

        # Maintains the index of the oldest char in long_sub
        start = 0

        for i, char in enumerate(s[1:], start=1):

            # Two cases:
            # Case1: char already exists in long_sub
            # Case2: char does't exists in long_sub set

            if char in long_sub:
                # Case1:
                # Remove the all lettters occurring before the previous occurence of the char

                while s[start] != char:
                    long_sub.remove(s[start])
                    start += 1
                start += 1

            else:
                # Case2: Simply add into the set
                long_sub.add(char)

            # Evaluate the length,
            # Case 1 may decrease the length
            # Case 2 will always increase the length.

            length = len(long_sub)
            if length > max_length:
                max_length = length
                #  [DEBUG:]   print(long_sub, length, max_length)

        return max_length
