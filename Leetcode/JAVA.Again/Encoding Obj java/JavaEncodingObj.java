public  Message filterSpecialErrorCharacter(Message msg) throws Exception{
    String serializedMsg = "";
    DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 140 ");
    ByteArrayOutputStream bo = new ByteArrayOutputStream();
    DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 110 ");
    ObjectOutputStream so = new ObjectOutputStream(bo);
    DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), " NO Error filter 144 ");
    try {
        // serialize the object
        try {
            so.writeObject(msg);
            so.flush();
//                serializedMsg = new String(Base64.encode(bo.toByteArray()));
            serializedMsg = new BASE64Encoder().encode(bo.toByteArray());

            DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 152 = " + serializedMsg);
        } catch (Exception e) {
            System.out.println(e);
            DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 154 = " + e.getMessage());
            DefaultLogger.error(CMSXMLGenerationHelper.class, e);
            return msg ;
        }

        //remove invalid Character
        String xml11pattern = "[^"
                + "\u0001-\uD7FF"
                + "\uE000-\uFFFD"
                + "\ud800\udc00-\udbff\udfff"
                + "]+";
        DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 164 - Before = " + msg.toString());
        serializedMsg = serializedMsg.replaceAll(xml11pattern , "");
        DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 167 - AFTER = " + msg.toString());

        // deserialize the object
        try {
//                byte b[] = Base64.decode(serializedMsg.getBytes());
            byte[] b = new BASE64Decoder().decodeBuffer(serializedMsg);
            ByteArrayInputStream bi = new ByteArrayInputStream(b);
            ObjectInputStream si = new ObjectInputStream(bi);
            DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 177 - AFTER obj = " + si.readObject());
            msg = (Message) si.readObject();
            DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 178 - AFTER obj = " + msg.toString());
        } catch (Exception e) {
            System.out.println(e);
            DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 173 = " + e.getMessage());
            DefaultLogger.error(CMSXMLGenerationHelper.class, e);
        }
    } catch (Exception e) {
        System.out.println(e);
        DefaultLogger.debug(CMSXMLGenerationHelper.class.getName(), "Error filter 154 = " + e.getMessage());
        DefaultLogger.error(CMSXMLGenerationHelper.class, e);
        return msg ;
    } finally {
        so.close();
        bo.close();
        return msg ;
    }
}