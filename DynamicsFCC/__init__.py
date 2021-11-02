# CanSum
from typing import List

store = {}


def canSum(self, nums: List[int], target: int, store) -> bool:
    # if cache, then return
    if target in store:
        return store[target]

    if target == 0:
        return True

    for num in nums:
        if num <= target:
            if self.canSum(nums, target - num, store):
                # cache the value
                store[target] = True
                return True

    return False


# howSum(target, number)
store2 = {}


def howSum(self, nums: List[int], target: int, store2) -> List[int]:
    # if cache, then return
    if not store2[target]:
        return []

    if target == 0:
        # store2[target] = True
        return [target]

    # Cache the False Value
    if target < 0:
        store2[target] = False
        return []

    for num in nums:
        listTemp = self.canSum(nums, target - num, store2)
        if len(listTemp) > 0:
            # cache the value
            return listTemp.append(target)

    return []
