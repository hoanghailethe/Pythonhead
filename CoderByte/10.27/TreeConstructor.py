# https://coderbyte.com/information/Tree%20Constructor

# This user scored higher than 72.8% of users who solved this challenge.
# 10 points
def TreeConstructor(strArr):
    # code goes here
    # the way to do this is to check if any parent node does not have 1 or two children node
    mapVal = {}
    children = []
    for pair in strArr:
        key = pair[3]
        mapVal[key] = mapVal.get(key, 0) + 1
        # check if the child is unique
        # child = pair[1]     WRONG HERE - 1 and 12 the same
        child = pair[1: pair.index(',')]
        if child not in children:
            children.append(child)
        else:
            return "false"

    for key in mapVal:
        if mapVal[key] > 2:
            return "false"
    return "true"


# keep this function call here
print(TreeConstructor(input()))

# after first RUN failed two test cases:
# 1. For input ["(2,5)", "(2,6)"] the output was incorrect. The correct output is false
# 2. For input ["(2,3)", "(1,2)", "(4,9)", "(9,3)", "(12,9)", "(6,4)", "(1,9)"] the output was incorrect. The correct output is false
# we must check if the child is unique too

# 1. For input ["(2,3)", "(1,2)", "(4,9)", "(9,3)", "(12,9)", "(6,4)"] the output was incorrect. The correct output is true

