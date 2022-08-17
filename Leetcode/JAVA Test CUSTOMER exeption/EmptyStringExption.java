public class EmptyStringExption extends Exception {
    String code ;
    String date ;

    public EmptyStringExption(String err, String code, String date) {
        super(err);
        this.code = code;
        this.date = date;
        System.out.println("EmptyStringExption");
    }

    public EmptyStringExption(String err) {
        super(err);
        System.out.println("EmptyStringExption");
    }
}
