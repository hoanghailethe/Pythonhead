class Result {

    /*
     * Complete the 'gradingStudents' function below.
     *
     * The function is expected to return an INTEGER_ARRAY.
     * The function accepts INTEGER_ARRAY grades as parameter.
     */

    public static List<Integer> gradingStudents(List<Integer> grades) {
    // Write your code here
        List<Integer> res = new ArrayList<>() ;
        for( int score : grades ) {
            if (score < 38 ) res.add(score) ;
            else {
                int remain = score %5 ;
                if(remain ==4 ) score += 1 ;
                else if(remain==3) score +=2 ;
                res.add(score) ;
            }
        }
        return res ;
    }

}