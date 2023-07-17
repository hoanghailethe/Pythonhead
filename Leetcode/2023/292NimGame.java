public boolean canWinNim(int n) {
        // 4n+3 -> n le la thua
       return n%4 >= 1 && n%4 <= 3 && (n/4)%2 != 0 ;

    }