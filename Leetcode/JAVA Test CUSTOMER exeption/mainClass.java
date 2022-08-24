// https://stackoverflow.com/questions/57857855/could-not-find-or-load-main-class-vs-code

public class mainClass {
    /**
     * @param args
     * @throws Exception
     */
    public static void main1(String[] args) {
        String empty = " ";
        String abc = "abc" ;
        // CheckValidString1 checker1 = new CheckValidString1();
     
        // direct use
        try{
            String res1 = CheckValidString1.checkString(empty);
            System.out.println(res1);
        } catch (EmptyStringExption e) {
            System.out.println(e.getMessage());
            System.out.println(e);
        } catch (BusinessException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println(e);
        }


        // try{
        //     String res2 = CheckValidString1.checkString(abc);
        //     System.out.println(res2);
        // } catch (EmptyStringExption e) {
        //     System.out.println(e.getMessage());
        //     System.out.println(e);
        // } catch (BusinessException e) {
        //     System.out.println(e);
        // } catch (Exception e) {
        //     System.out.println(e);
        // }

        //test by 1 more user layer
        System.out.println("check throught layers");
        CheckValidStringUser userLayer = new CheckValidStringUser();
        try{
            userLayer.useCheckValidString1(empty);
            
        } catch (EmptyStringExption e) {
            System.out.println("EXP COME HERE1");
            System.out.println(e.getMessage());
            System.out.println(e);
        } catch (BusinessException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println("EXP COME HERE2 PARENT");
            System.out.println(e);
        }

        // non error
        try{
            userLayer.useCheckValidString1(abc);
            
        } catch (EmptyStringExption e) {
            System.out.println("EXP COME HERE1");
            System.out.println(e.getMessage());
            System.out.println(e);
        } catch (BusinessException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println("EXP COME HERE 2 PARENT");
            System.out.println(e);
        }

        System.out.println("CAST to child exeption");
        try{
            userLayer.useCheckValidString1(empty);
            
        // } catch (EmptyStringExption e) {
        //     System.out.println("EXP COME HERE1");
        //     System.out.println(e.getMessage());
        //     System.out.println(e);
        } catch (BusinessException e) {
            System.out.println(e);
        } catch (Exception e) {
            System.out.println("EXP COME HERE 2 PARENT");
            if (e instanceof EmptyStringExption) {
                System.out.println("BEGIN CASTING");
                EmptyStringExption e_casted = (EmptyStringExption) e ;
                System.out.println("Casted successfully");
                System.out.println(e_casted);
            }
            else System.out.println(e);
        }
    }

    public static int Average (Integer[] nums) {
        if (nums.length == 0) return 0;
        int sum = 0 ;
        for (Integer num : nums) {
            sum += num;
        }
        return sum / nums.length ;
    }


    public static void main(String[] args) {
        Integer[] nums = {1,33,55 ,99} ;
        int average = Average(nums) ;
        System.out.println(average);

        if(average >= 10 ) {
            System.out.println("Double digits");
        } else {
            System.out.println("Single digits");
        }
    }


}


