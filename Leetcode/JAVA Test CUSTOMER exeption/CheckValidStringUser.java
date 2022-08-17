public class CheckValidStringUser
 {
    public void useCheckValidString1(String test) throws Exception{
        System.out.println("Start checking");

        try {
            CheckValidString1.checkString(test);
        } catch (Exception e ) {
            System.out.println("useCheckValidString1 Exception Type (cast from EmptyString)");
            System.out.println(e);
            //must throw another for children to catch
            throw e;
        }
        System.out.println("CHECK DONE ALL GOOD");
    }
}
