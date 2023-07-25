public class 387FirstUniqueChar {
    public int firstUniqChar(String s) {
        HashMap<Character, Integer> map = new HashMap() ;
        for (char c : s.toCharArray()) {
            map.put(c, map.getOrDefault(c, 0) + 1) ;
        }

        for(char c : s.toCharArray()) {
            // System.out.println(c) ;
            //    System.out.println(map.get(c)) ;
            if (map.get(c)==1){ 
                return s.indexOf(c);
            }
        }

        return -1 ;
    }

//     Runtime
// Details
// 37ms
// Beats 47.30%of users with Java
// Memory
// Details
// 44.29mb
// Beats 54.38%of users with Java
}
