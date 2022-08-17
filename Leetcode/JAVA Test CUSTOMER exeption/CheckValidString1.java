public class CheckValidString1{
    // public CheckValidString1() {
    // }
    
    static String checkString(String input) throws Exception {
        if(input==null || input.trim().equals("") ) throw new EmptyStringExption("invalid Empty string");
        else return "good String";
    }
}