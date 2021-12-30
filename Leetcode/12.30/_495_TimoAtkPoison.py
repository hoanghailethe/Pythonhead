class Solution:
    # Time exceed limit
    def findPoisonedDuration(self, timeSeries: List[int], duration: int) -> int:
        sec_poinsened = 0
        start_poisoning = 0
        last_time = timeSeries[len(timeSeries) - 1]

        for time in range(1, last_time + 1 + duration):
            if time in timeSeries:
                start_poisoning = time
            if time in range(start_poisoning, start_poisoning + duration):
                sec_poinsened += 1
        return sec_poinsened


    def findPoisonedDuration2(self, timeSeries: List[int], duration: int) -> int:
        total = 0
        last_time = -99999
        for time in timeSeries:
            if time < last_time + duration:
                total -= (last_time + duration - time)
            total += duration
            last_time = time
        return total