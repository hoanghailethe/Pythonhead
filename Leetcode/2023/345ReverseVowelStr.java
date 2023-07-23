public class 345ReverseVowelStr {
    // Runtime
    // Details
    // 114ms
    // Beats 17.26%of users with Java
    // Memory
    // Details
    // 44.82mb
    // Beats 23.53%of users with Java

    public String reverseVowels(String s) {

        char[] ca = s.toCharArray() ;
        char[]vowels = {'a', 'e', 'i', 'o','u','A', 'E' , 'I' , 'O' , 'U'} ;

        // List vowelsList = Arrays.asList(vowels);
        List<Character> vowelsList = new ArrayList() ;
        for(char vowel : vowels) {
            vowelsList.add(vowel) ;
        }

        int b = 0 ;
        int e = s.length() - 1 ;

        // System.out.println(vowelsList);
        // System.out.println(vowelsList.contains('e')); //false

        while ( b < e) {
            while(b < e && vowelsList.contains(ca[b]) ==false ) {
                System.out.println(b + " " + e);
                b++ ;
            }
            while(b < e&& vowelsList.contains(ca[e]) ==false) {
                e-- ;
            }
            if(b >= e) break ;
            
            char temp = ca[b] ;
            ca[b] = ca[e] ;
            ca[e] = temp ;
            b++ ; e--;
            System.out.println("b " + temp +" e "+ ca[b] );

        }
        return new String (ca) ;
        
    }


    public String reverseVowels(String s) {
        char arr[] = s.toCharArray();
        int i = 0, j = s.length() - 1;
        
        while (i < j) {
            if (arr[i] != 'a' && arr[i] != 'e' && arr[i] != 'i' && arr[i] != 'o' && arr[i] != 'u' &&
                arr[i] != 'A' && arr[i] != 'E' && arr[i] != 'I' && arr[i] != 'O' && arr[i] != 'U')
                i++;
            else if (arr[j] != 'a' && arr[j] != 'e' && arr[j] != 'i' && arr[j] != 'o' && arr[j] != 'u' &&
                     arr[j] != 'A' && arr[j] != 'E' && arr[j] != 'I' && arr[j] != 'O' && arr[j] != 'U')
                j--;
            else {
                char ch = arr[i];
                arr[i] = arr[j];
                arr[j] = ch;
                i++;
                j--;
            } 
        }
        
        return new String(arr);
    }
}
