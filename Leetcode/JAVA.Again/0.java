class Indentify_Obj {

    public List<String> indentify_att_id;

    public Indentify_Obj( String[] indentify ) {
        indentify_att_id = Arrays.asList(indentify);      
    } 
//    String [] {"id1", "id2"} ;
    
  
    String id; 

    public boolean areYou(String name) {
        return indentify_att_id.contains(name); 
    }

    public String firstId() {
        if(indentify_att_id.isEmpty()) return null;
        else return indentify_att_id.get(0);
    }
    public void addIndentifier(String id) {
        String newID = id.toLowerCase() ;
        indentify_att_id.add(newID);
    }

}


main {
    String test = String [] {"id1", "id2"} ;
    Indentify_Obj ind_ojc = new Indentify_Obj(test);


}