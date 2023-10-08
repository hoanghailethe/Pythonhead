public class 819MostCommonWord {
    public String mostCommonWord(String paragraph, String[] banned) {
        Set<String>bannedSet = new HashSet() ;
        for(String ban : banned ) {
            bannedSet.add(ban);
        }

        int mostAppearNo = 0;
        String mostAppWord ="";

        paragraph = paragraph.replaceAll("[^a-zA-Z0-9]", " ");
        String[]words= paragraph.toLowerCase().split(" ") ;
        Map<String, Integer > map = new HashMap() ;
        for(String word : words) {
            System.out.println(word);
            if("".equals(word.trim()) == false && bannedSet.contains(word) == false ){
                int newTime = map.getOrDefault(word, 0) + 1;
                map.put(word, newTime) ;
                
                if(newTime>mostAppearNo) {
                    mostAppearNo=newTime; 
                    mostAppWord=word;
                }
            }
        }
        return mostAppWord ;

        
    }
}
