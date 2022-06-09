class Solution:
    def tictactoe(self, moves: List[List[int]]) -> str:
        player = 'A'
        table = [[[],[],[]],[[],[],[]],[[],[],[]]]

        for move in moves:
            x = move[0]
            y = move[1]
            table[x][y] = player
            if player == 'A' :
                player = 'B'
            else: player = 'A'

        def checkWinner(cell) :
            x = cell[0]
            y = cell[1]

            if moves[]

        for id, val in enumerate(moves):
            checkWinner( val )