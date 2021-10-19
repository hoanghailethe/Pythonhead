#!/bin/python3
# https://www.hackerrank.com/challenges/electronics-shop/problem?isFullScreen=true
# pass all. Score : 15.0

import os
import sys

#
# Complete the getMoneySpent function below.
#
def getMoneySpent(keyboards, drives, b):
    max_price = -1
    for k in keyboards:
        if k >= b:
            continue
        for d in drives:
            if d >= b:
                continue
            elif k + d <= b:
                max_price = max(k+d, max_price)
    return max_price

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    bnm = input().split()

    b = int(bnm[0])

    n = int(bnm[1])

    m = int(bnm[2])

    keyboards = list(map(int, input().rstrip().split()))

    drives = list(map(int, input().rstrip().split()))

    #
    # The maximum amount of money she can spend on a keyboard and USB drive, or -1 if she can't purchase both items
    #

    moneySpent = getMoneySpent(keyboards, drives, b)

    fptr.write(str(moneySpent) + '\n')

    fptr.close()
