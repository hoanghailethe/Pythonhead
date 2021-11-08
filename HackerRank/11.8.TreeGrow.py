# https://www.hackerrank.com/challenges/utopian-tree/problem?isFullScreen=true


#
# Complete the 'utopianTree' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER n as parameter.
#

def utopianTree(n):
    # Write your code here
    is_spring = True
    height = 1
    for i in range(1, n + 1):
        if is_spring:
            height *= 2
        else:
            height += 1

        is_spring = not is_spring
    return height

