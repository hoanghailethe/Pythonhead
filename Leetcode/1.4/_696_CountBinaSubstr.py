class Solution:
    def countBinarySubstrings(self, s: str) -> int:
        s = s + 'e'
        lastChar = ""
        strin = "" + s[0]
        holder = []
        one = 0
        zero = 0
        # "00110011"
        for a in s:
            if lastChar != a:
                if one != 0 and zero != 0:
                    num_cut = min(one, zero)
                    # print(num_cut) | 2 2 4
                    add = strin[(-2*num_cut):]
                    holder.append(add)

                    strin = add + a 
                if a == '1' and one > zero: 
                    zero = 0
                elif a== '0' and zero > one:
                    one = 0
            
            if a == '1':
                one += 1
                
            if a == '0':
                zero += 1
                
            lastChar = a
        
        # ['', '0', '01']
        return len(holder)

    # Cùng 1 cách làm nhưng thực hiện ý tưởng tốt hơn mình
    # public int countBinarySubstrings(String s) {
    #     int ans = 0; 
    #     int i = 0;
    #     int prev = 0;
    #     while (i < s.length()) {
    #         int total = 0;
    #         while (i < s.length() && s.charAt(i) == '1') {
    #             total++;
    #             i++;
    #         }
    #         if (total > 0) {
    #             ans += Math.min(prev, total);
    #             prev = total; 
    #         }
            
    #         total = 0;
    #         while (i < s.length() && s.charAt(i) == '0') {
    #             total++;
    #             i++;
    #         }
            
    #         if (total > 0) {
    #             ans += Math.min(prev, total); 
    #             prev = total; 
    #         }
            
    #     }
        
    #     return ans;
    # }