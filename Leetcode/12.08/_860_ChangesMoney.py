class Solution:
    money_bank = {20: 0, 10: 0, 5: 0}
    money_title = [20, 10, 5]  # ak=lready sorted

    def give_back_change(self, overpay, take_money) -> int :
        if overpay == 0:
            money_bank[take_money] = money_bank.get(take_money) + 1
            return 0

        for money in money_title:
            if overpay > money and money_bank.get(money) > 0 :
                money_bank[change] = money_bank.get(change) - 1
                return give_back_change(overpay-5, take_money)

        return overpay


    def lemonadeChange(self, bills: List[int]) -> bool:
        for take_money in bills :
            overpay = take_money - 5
            give_back_change(overpay, take_money)


            continue

        return True