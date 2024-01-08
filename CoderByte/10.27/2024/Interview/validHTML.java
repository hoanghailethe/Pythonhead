import java.util.LinkedList;
import java.util.Queue;

public class HTMLTagChecker {
    public static void main(String[] args) {
        String htmlString = "<div><p>Content</p></div>";

        String result = checkHTMLTags(htmlString);

        if ("true".equals(result)) {
            System.out.println("HTML tags are correctly closed.");
        } else {
            System.out.println("Fix the following tag: " + result);
        }
    }

    private static String checkHTMLTags(String htmlString) {
        Queue<String> tagQueue = new LinkedList<>();

        // Loop through each character in the string
        for (int i = 0; i < htmlString.length(); i++) {
            char currentChar = htmlString.charAt(i);

            // Check for the start of an HTML tag
            if (currentChar == '<') {
                // Find the end of the tag
                int endIndex = htmlString.indexOf('>', i + 1);

                if (endIndex == -1) {
                    // If no closing '>' is found, the tags are not correctly closed
                    return htmlString.substring(i, i + 1);
                }

                // Extract the tag
                String tag = htmlString.substring(i + 1, endIndex);

                // Check if it is an opening or closing tag
                if (!tag.startsWith("/")) {
                    // Opening tag - add it to the queue
                    tagQueue.offer(tag);
                } else {
                    // Closing tag - check if it matches the last opened tag
                    String openTag = tagQueue.poll();
                    if (openTag == null || !openTag.equals(tag.substring(1))) {
                        // Mismatched closing tag
                        return "<" + tag.substring(1) + ">";
                    }
                }

                // Move the index to the end of the tag
                i = endIndex;
            }
        }

        // Check if all tags are closed
        return tagQueue.isEmpty() ? "true" : ("<" + tagQueue.poll() + ">");
    }
}


import java.util.Stack;

public class HTMLTagChecker {
    public static void main(String[] args) {
        String htmlString = "<div><p>Content</p></div>";

        String result = checkHTMLTags(htmlString);

        if ("true".equals(result)) {
            System.out.println("HTML tags are correctly closed.");
        } else {
            System.out.println("Fix the following tag: " + result);
        }
    }

    private static String checkHTMLTags(String htmlString) {
        Stack<String> tagStack = new Stack<>();

        // Loop through each character in the string
        for (int i = 0; i < htmlString.length(); i++) {
            char currentChar = htmlString.charAt(i);

            // Check for the start of an HTML tag
            if (currentChar == '<') {
                // Find the end of the tag
                int endIndex = htmlString.indexOf('>', i + 1);

                if (endIndex == -1) {
                    // If no closing '>' is found, the tags are not correctly closed
                    return htmlString.substring(i, i + 1);
                }

                // Extract the tag
                String tag = htmlString.substring(i + 1, endIndex);

                // Check if it is an opening or closing tag
                if (!tag.startsWith("/")) {
                    // Opening tag - push it onto the stack
                    tagStack.push(tag);
                } else {
                    // Closing tag - check if it matches the last opened tag
                    if (tagStack.isEmpty() || !tagStack.pop().equals(tag.substring(1))) {
                        // Mismatched closing tag
                        return "<" + tag.substring(1) + ">";
                    }
                }

                // Move the index to the end of the tag
                i = endIndex;
            }
        }

        // Check if all tags are closed
        return tagStack.isEmpty() ? "true" : ("<" + tagStack.pop() + ">");
    }
}


