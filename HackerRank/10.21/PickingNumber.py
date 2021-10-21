#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'pickingNumbers' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY a as parameter.
#


# Unclear Requirement => Stop
def pickingNumbers(a):
    # Write your code here
    a_size = len(a)
    max_len = 0
    begin = 0
    end = 0
    a.sort()

    # checker = {}
    # for num in a:
    #     key = str(num)
    #     val = checker.get(key, 0)
    #     checker[key] = val
    # print(checker)

    for i in range(a_size-1):
        if abs(a[i]-a[i+1]) < 2: 
            end = i + 1  
        else:
            max_len = max(end + 1 - begin, max_len)
            begin = i
    return max_len
            
