class Solution:

    # Runtime: 4682 ms, faster than 5.04% of Python3
    # Memory Usage: 18.2 MB, less than 80.79%
    def lemonadeChange(self, bills: List[int]) -> bool:
        money_bank = []
        # count_money_bank = {}
        for take_money in bills :
            overpay = take_money - 5
            money_bank.sort()
            while overpay > 0 and money_bank:
                if overpay not in money_bank:
                    # find the first max value that less than overpay
                    ind = len(money_bank) - 1
                    while ind >= 0 and money_bank[ind] > overpay:
                        ind -= 1
                    if ind == -1:
                        return False
                    else:
                        overpay -= money_bank.pop(ind)

                if overpay in money_bank:
                    money_bank.remove(overpay)
                    overpay = 0

            if overpay > 0:
                return False
            else:
                money_bank.append(take_money)
                # print(money_bank)
        return True

    def lemonadeChange2(self, bills: List[int]) -> bool:

        fives = 0
        tens = 0
        twenties = 0

        ans = True

        for el in bills:

            if el == 5:
                fives += 1
            elif el == 10:
                if fives > 0:
                    tens += 1
                    fives -= 1
                else:
                    ans = False
                    break

            elif el == 20:
                if tens > 0 and fives > 0:
                    tens -= 1
                    fives -= 1
                    twenties += 1
                elif fives >= 3:
                    fives -= 3
                    twenties += 1
                else:
                    ans = False
                    break
        return ans

    def lemonadeChange(self, bills: List[int]) -> bool:
        n = len(bills)
        fives = tens = 0
        for bill in bills:
            if bill == 5:
                fives += 1
            elif bill == 10:
                fives, tens = fives - 1, tens + 1
            elif tens > 0:
                fives, tens = fives - 1, tens - 1
            else:
                fives -= 3
            if fives < 0: return False
        return True