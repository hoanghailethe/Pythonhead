class Solution:
    # Runtime: 60 ms, faster than 68.12% of Python3
    # Memory Usage: 14.4 MB, less than 50.56% of Python3
    def judgeCircle(self, moves: str) -> bool:
        x = 0
        y = 0

        if len(moves) % 2 != 0:
            return False

        for move in moves:
            if move == 'R':
                x += 1
            elif move == 'L':
                x -= 1
            elif move == 'U':
                y += 1
            elif move == 'D':
                y -= 1

        return x == 0 and y == 0