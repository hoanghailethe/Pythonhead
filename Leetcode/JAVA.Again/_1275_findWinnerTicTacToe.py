from sqlite3 import Row


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

        def checkWinner(table) :
            col_size = len(table[0])
            row_size = len(table)
            # check col
            for i in range(col_size):
                if table[0][i] == table[1][i] == table[2][i]:
                    return table[0][i]

            # check Row
            for i in range(row_size):
                if table[i][0] == table[i][1] == table[i][2]:
                    return table[i][0]

            # check dianoge
            if table[0][0] == table[1][1] == table[2][2]:
                return table[0][0]
            elif table[0][2] == table[1][1] == table[2][0]:
                return table[0][2]
            
            if len(moves) == 9:
                return 'Draw'
            else: 
                return 'Pending'

        return checkWinner( table )


    def tictactoe(self, moves: List[List[int]]) -> str:
        #build board
        board = [
            ['','',''],
            ['','',''],
            ['','','']
        ]
        p1 = 'A'
        p2 = 'B'
        player_one = True
        for row, col in moves:
            if player_one:
                board[row][col] = p1
            else: 
                board[row][col] = p2
            player_one = not player_one
        
        #check row wins
        for row in range(len(board)):
            player = board[row][0]
            if not player: continue
            winner = True
            for col in range(1, len(board[0])):
                if board[row][col] != player:
                    winner = False
            if winner:
                return player
        
        #check col wins
        for col in range(len(board[0])):
            player = board[0][col]
            if not player: continue
            winner = True
            for row in range(1, len(board)):
                if board[row][col] != player:
                    winner = False
            if winner:
                return player
            
        #check diagonals
        upper_left = board[0][0]
        if upper_left and upper_left == board[1][1] and upper_left == board[2][2]:
            return upper_left
        upper_right = board[0][2]
        if upper_right and upper_right == board[1][1] and upper_right == board[2][0]:
            return upper_right
        
        return 'Pending' if len(moves) < 9 else 'Draw'