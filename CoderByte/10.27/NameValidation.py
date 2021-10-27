# https://coderbyte.com/editor/Codeland%20Username%20Validation:Python3
# https://quantrimang.com/regex-trong-python-165471

import re

# my answer is wrong
def CodelandUsernameValidation(strParam):
    if len(strParam) not in range(4, 26):
        return False

        # code goes here
    pattern = '[a-zA-Z][\w]+[^_]'
    result = re.match(pattern, strParam)

    return result


def CodelandUsernameValidation2(str):
  pattern = re.compile(r"^[a-zA-Z][\w_]{2,23}[^_]$")
  res = pattern.match(str)
  str = "true" if res else "false"
  return str



def CodelandUsernameValidation3(s):
  if len(s)>4 and len(s)<25 and s[0].isalpha() and [i for i in s if i.isalnum() or i=="_"]!=[] and s[-1]!="_":
    return True
  else:
    return False



def CodelandUsernameValidation4(str):
    ascii_letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789'

    a = len(str) >= 4 and len(str) <= 25
    b = str[0].isalpha()
    c = str[-1] != "_"
    if a and b and c:
        pass
        for i in str:
            if i in ascii_letters:
                message = "true"

            else:
                message = "false"
                break
    else:
        message = "false"


# keep this function call here
print(CodelandUsernameValidation(input()))
