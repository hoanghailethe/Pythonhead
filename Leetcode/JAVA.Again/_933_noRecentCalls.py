class RecentCounter:
# Runtime: 283 ms, faster than 87.45% of Python3 online submissions for Number of Recent Calls.
# Memory Usage: 19.4 MB, less than 90.09% of Python3 online submissions for Number of Recent Calls.
    def __init__(self):
        self.recent = []

    def ping(self, t: int) -> int:
        self.recent.append(t)
        while self.recent[0] < t-3000:
            self.recent.pop(0)
        return len(self.recent)


# Your RecentCounter object will be instantiated and called as such:
# obj = RecentCounter()
# param_1 = obj.ping(t)