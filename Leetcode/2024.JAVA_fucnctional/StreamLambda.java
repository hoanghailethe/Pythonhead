public class StreamLambda {
    public static void main(String[] args) {
        // Creating a List
        List<String> stringList = new ArrayList<>();
        stringList.add("Java");
        stringList.add("Python");
        stringList.add("C++");

        // Converting List to Array
        String[] stringArray = stringList.toArray(new String[0]);

        // Printing the elements of the array
        for (String language : stringArray) {
            System.out.println(language);
        }

        // Creating a HashMap
        Map<String, Integer> hashMap = new HashMap<>();
        hashMap.put("One", 1);
        hashMap.put("Two", 2);
        hashMap.put("Three", 3);
        hashMap.put("Four", 4);

        // Using Streams and Map to iterate quickly
        hashMap.entrySet().stream()
                .map(entry -> "Key: " + entry.getKey() + ", Value: " + entry.getValue())
                .forEach(System.out::println);

        list.forEach(System.out::println);

        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            System.out.println("Key: " + entry.getKey() + ", Value: " + entry.getValue());
        }

        map.forEach((key, value) -> System.out.println("Key: " + key + ", Value: " + value));

        int[] array = { 1, 2, 3, 4, 5 };

        IntStream.range(0, array.length)
                .forEach(i -> {
                    int value = array[i];
                    // Use index (i) and value as needed
                    System.out.println("Index: " + i + ", Value: " + value);

                    // Modify the value if needed
                    array[i] = value * 2;
                });

        List<Integer> list = Arrays.asList(1, 2, 3, 4, 5);

        IntStream.range(0, list.size())
                .forEach(i -> {
                    int value = list.get(i);
                    // Use index (i) and value as needed
                    System.out.println("Index: " + i + ", Value: " + value);

                    // Modify the value if needed
                    list.set(i, value * 2);
                });

        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

        boolean found = numbers.stream()
                .anyMatch(num -> {
                    // Your condition for early exit
                    if (num == 3) {
                        System.out.println("Found it!");
                        return true; // exit early
                    }
                    return false;
                });

        // forloop in for loop

        List<List<Integer>> matrix = Arrays.asList(
                Arrays.asList(1, 2, 3),
                Arrays.asList(4, 5, 6),
                Arrays.asList(7, 8, 9));

        matrix.forEach(row -> row.forEach(value -> {
            // Your code here
            System.out.println(value);
        }));

        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

        // Using a stream to transform data immutably
        List<Integer> doubledNumbers = numbers.stream()
                .map(num -> num * 2)
                .collect(Collectors.toList());

        List<String> words = Arrays.asList("apple", "banana", "cherry");

        // Using a stream to filter and transform data
        List<String> result = words.stream()
                .filter(word -> word.length() > 5)
                .map(String::toUpperCase)
                .collect(Collectors.toList());

        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

        // Filter numbers greater than 2
        List<Integer> filteredNumbers = numbers.stream()
                .filter(num -> num > 2)
                .collect(Collectors.toList());

        System.out.println(filteredNumbers); // Output: [3, 4, 5]

        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

        // Square each number
        List<Integer> squaredNumbers = numbers.stream()
                .map(num -> num * num)
                .collect(Collectors.toList());

        System.out.println(squaredNumbers); // Output: [1, 4, 9, 16, 25]

        List<Integer> result = numbers.stream()
                .filter(num -> num > 2)
                .map(num -> num * 2)
                .collect(Collectors.toList());

        // Convert array to stream
        int[] array = { 1, 2, 3, 4, 5 };
        Arrays.stream(array)
                .forEach(System.out::println);

        // Convert array to list
        List<Integer> list = Arrays.stream(array)
                .boxed()
                .collect(Collectors.toList());

        System.out.println(list);

        // Convert array to list using Arrays.asList()
        String[] stringArray = { "apple", "banana", "cherry" };
        List<String> stringList = Arrays.asList(stringArray);

        // Convert array to list using stream
        List<String> anotherList = Arrays.stream(stringArray)
                .collect(Collectors.toList());

        System.out.println(stringList);
        System.out.println(anotherList);

    }
}