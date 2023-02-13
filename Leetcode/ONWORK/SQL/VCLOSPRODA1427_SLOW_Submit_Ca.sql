SELECT * FROM SML_CA ;

SELECT  FAC.ID FROM SML_FACILITY FAC INNER JOIN SML_CA CA ON FAC.CA_ID = CA.ID ;

SELECT fac.CA_ID, COUNT(fac.id) no_fac FROM sml_facility fac GROUP BY fac.ca_id ORDER BY no_fac DESC; 
--201903280000023541	321
--201906200000023582	321
--201906200000023584	321
--201704040000022922	320
--201705080000023104	251
--201903280000023543	212
--20140428008202	103
--202004220000023591	102

SELECT * FROM SML_CA WHERE ID = 202004220000023591; 
--202004220000023591	103	rmhoangyen01	22-APR-20	rmhoangyen01    CAR/16/0001/00122/00007946

--more CAR
201705080000023104	251
201704040000022922	320


--COPY CLOS COL - to SAUBMIT LIGHT CẢ with a COL
Search 'PT20130826007376'; --copy col


--DATE 2/13/23
Change date to submib FAC 
    public List<IApprovalMemoFacilityMin> getLatestAmFacilityMinListWithOutSubFacilityByCaId(long caId) {
        String query = "HQL.getLatestAmFacilityMinListWithOutSubFacilityByCaId(caId)";

        from approvalMemoFacilityMin amFac 
        where amFac.amId = (
            select am.id from com.integrosys.sml.app.financialpackage.approvalmemo.vo.OBApprovalMemo as am
            where am.creationDate = (
                select max(am2.creationDate) from com.integrosys.sml.app.financialpackage.approvalmemo.vo.OBApprovalMemo as am2
                where am2.caId = :caId
            )
        )
        order by amFac.facilityId

        SML_AM_FACILITY
        <property name="facilityNo" column="FAC_NO" />
<property name="expiryDate" column="EXPIRY_DATE" />

SELECT * FROM SML_AM_FACILITY ;
SELECT * FROM SML_AM_FACILITY WHERE fac_no = 2016102600014108;


UPDATE SML_AM_FACILITY SET EXPIRY_DATE = (SYSDATE + 60) WHERE fac_no = 2016102600014108; 
COMMIT ;

--still hit
public List<IFacility> getAllFacilityWithOutSubFacilityListByCaId(long caId){
		 String query = "HQL.getAllFacilityWithOutSubFacilityListByCaId"
<query name="HQL.getAllFacilityWithOutSubFacilityListByCaId">
    <![CDATA[
        from com.integrosys.sml.app.facility.vo.OBFacility as fac 
        where fac.caId = :caId and
        fac.deprecated = 'N' 
        order by fac.id 
        
        SML_FACILITY

SELECT * FROM SML_FACILITY;
SELECT * FROM SML_FACILITY WHERE FAC_NO = 2016102600014108;

UPDATE SML_FACILITY SET EXPIRY_DATE = (SYSDATE + 60) WHERE fac_no = 2016102600014108; 
COMMIT ;
-- similar : 2016102600014109
UPDATE SML_FACILITY SET EXPIRY_DATE = (SYSDATE + 60) WHERE fac_no = 2016102600014109; 

bATCH CAHANGE : FP Id :202004220000023591

select fac_no from SML_FACILITY fac where fac.ca_Id = 202004220000023591 and fac.deprecated = 'N' and fac.expiry_date > trunc(sysdate) order by fac.id ;

UPDATE SML_FACILITY SET EXPIRY_DATE = (SYSDATE + 60) WHERE fac_no IN 
(select fac_no from SML_FACILITY fac where fac.ca_Id = 202004220000023591 and fac.deprecated = 'N' and fac.expiry_date > trunc(sysdate)) ;
COMMIT; 

message != null && message.contains("NOACCOUNTFOUND")
        //Alse FAC child
        List<IApprovalMemoFacilityMin> childFacilities;


UPDATE SML_FACILITY SET EXPIRY_DATE = (SYSDATE + 60) WHERE fac_no IN (2016102600014113, 2016102600014114,
2016102600014115,
2016102600014116,
2016102600014117,
2016102600014118,
2016102600014119,
2016102600014120,
2016102600014121,
2016102600014122,
2016102600014123,2016102600014124,2016102600014125,2016102600014126,2016102600014127,2016102600014128,2016102600014129,2016102600014130,2016102600014131,2016102600014132,2016102600014133,2016102600014134); 
COMMIT ;


SELECT * FROM SML_CA WHERE ID IN (201906200000023582, 201705080000023104, 201903280000023543) ;
CAR/17/0001/00122/00008704  PENDING APPROVED
CAR/19/0001/00122/00009153
CAR/19/0001/00122/00009192

rmklinh001
CAR/17/0001/00122/00008524
CAR/19/0001/00122/00009151
CAR/19/0001/00122/00009194

--201903280000023541	321
--201906200000023582	321
--201906200000023584	321
--201704040000022922	320
--201705080000023104	251
--201903280000023543	212
--20140428008202	103
--202004220000023591	102

UPDATE SML_FACILITY SET EXPIRY_DATE = (SYSDATE + 60) WHERE fac_no IN  (2017050800015117,2017050800015118,2017050800015119,2017050800015120,2017050800015121,2017050800015122,2017050800015123,2017050800015124,2017050800015125,2017050800015126,2017050800015127,2017050800015128,2017050800015129,2017050800015130,2017050800015131,2017050800015132,2017050800015133,2017050800015134,2017050800015135,2017050800015136,2017050800015137,2017050800015137,2017050800015138,2017050800015138,2017050800015139,2017050800015139,2017050800015140,2017050800015140,2017050800015141,2017050800015142,2017050800015143,2017050800015144,2017050800015145,2017050800015146,2017050800015147,2017050800015148,2017050800015149,2017050800015150,2017050800015151,2017050800015152,2017050800015153,2017050800015154,2017050800015155,2017050800015156,2017050800015157,2017050800015158,2017050800015159,2017050800015160,2017050800015161,2017050800015162,2017050800015163,2017050800015164,2017050800015165,2017050800015166,2017050800015167,2017050800015168,2017050800015169,2017050800015170,2017050800015171,2017050800015172,2017050800015173,2017050800015174,2017050800015175,2017050800015176,2017050800015177,2017050800015178,2017050800015179,2017050800015180,2017050800015181,2017050800015182,2017050800015183,2017050800015184,2017050800015185,2017050800015186,2017050800015187,2017050800015188,2017050800015189,2017050800015190,2017050800015191,2017050800015192,2017050800015193,2017050800015194,2017050800015195,2017050800015196,2017050800015197,2017050800015198,2017050800015199,2017050800015200,2017050800015201,2017050800015202,2017050800015203,2017050800015204,2017050800015205,2017050800015206,2017050800015207,2017050800015208,2017050800015209,2017050800015210,2017050800015211,2017050800015212,2017050800015213,2017050800015214,2017050800015215,2017050800015216,2017050800015217,2017050800015218,2017050800015219,2017050800015220,2017050800015221,2017050800015222,2017050800015223,2017050800015224,2017050800015225,2017050800015226,2017050800015227,2017050800015228,2017050800015229,2017050800015230,2017050800015231,2017050800015232,2017050800015233,2017050800015234,2017050800015235,2017050800015236,2017050800015237,2017050800015238,2017050800015239,2017050800015240,2017050800015241,2017050800015242,2017050800015243,2017050800015244,2017050800015245,2017050800015246,2017050800015247,2017050800015248,2017050800015249,2017050800015250,2017050800015251,2017050800015252,2017050800015253,2017050800015254,2017050800015255,2017050800015256,2017050800015257,2017050800015258,2017050800015259,2017050800015260,2017050800015261,2017050800015262,2017050800015263,2017050800015264,2017050800015265,2017050800015266,2017050800015267,2017050800015268,2017050800015269,2017050800015270,2017050800015271,2017050800015272,2017050800015273,2017050800015274,2017050800015275) ;
COMMIT ;

UPDATE SML_FACILITY SET EXPIRY_DATE = (SYSDATE + 60) WHERE fac_no IN  (2017050800015117,2017050800015118,2017050800015119,2017050800015120,2017050800015121,2017050800015122,2017050800015123,2017050800015124,2017050800015125,2017050800015126,2017050800015127,2017050800015128,2017050800015129,2017050800015130,2017050800015131,2017050800015132,2017050800015133,2017050800015134,2017050800015135,2017050800015136,2017050800015137,2017050800015137,2017050800015138,2017050800015138,2017050800015139,2017050800015139,2017050800015140,2017050800015140,2017050800015141,2017050800015142,2017050800015143,2017050800015144,2017050800015145,2017050800015146,2017050800015147,2017050800015148,2017050800015149,2017050800015150,2017050800015151,2017050800015152,2017050800015153,2017050800015154,2017050800015155,2017050800015156,2017050800015157,2017050800015158,2017050800015159,2017050800015160,2017050800015161,2017050800015162,2017050800015163,2017050800015164,2017050800015165,2017050800015166,2017050800015167,2017050800015168,2017050800015169,2017050800015170,2017050800015171,2017050800015172,2017050800015173,2017050800015174,2017050800015175,2017050800015176,2017050800015177,2017050800015178,2017050800015179,2017050800015180,2017050800015181,2017050800015182,2017050800015183,2017050800015184,2017050800015185,2017050800015186,2017050800015187,2017050800015188,2017050800015189,2017050800015190,2017050800015191,2017050800015192,2017050800015193,2017050800015194,2017050800015195,2017050800015196,2017050800015197,2017050800015198,2017050800015199,2017050800015200,2017050800015201,2017050800015202,2017050800015203,2017050800015204,2017050800015205,2017050800015206,2017050800015207,2017050800015208,2017050800015209,2017050800015210,2017050800015211,2017050800015212,2017050800015213,2017050800015214,2017050800015215,2017050800015216,2017050800015217,2017050800015218,2017050800015219,2017050800015220,2017050800015221,2017050800015222,2017050800015223,2017050800015224,2017050800015225,2017050800015226,2017050800015227,2017050800015228,2017050800015229,2017050800015230,2017050800015231,2017050800015232,2017050800015233,2017050800015234,2017050800015235,2017050800015236,2017050800015237,2017050800015238,2017050800015239,2017050800015240,2017050800015241,2017050800015242,2017050800015243,2017050800015244,2017050800015245,2017050800015246,2017050800015247,2017050800015248,2017050800015249,2017050800015250,2017050800015251,2017050800015252,2017050800015253,2017050800015254,2017050800015255,2017050800015256,2017050800015257,2017050800015258,2017050800015259,2017050800015260,2017050800015261,2017050800015262,2017050800015263,2017050800015264,2017050800015265,2017050800015266,2017050800015267,2017050800015268,2017050800015269,2017050800015270,2017050800015271,2017050800015272,2017050800015273,2017050800015274,2017050800015275) ;
COMMIT ;

UPDATE SML_FACILITY SET EXPIRY_DATE = (SYSDATE + 60) WHERE fac_no IN (2017050800015023,2017050800015024,2017050800015025,2017050800015026,2017050800015027,2017050800015028,2017050800015029,2017050800015030,2017050800015031,2017050800015032,2017050800015033,2017050800015034,2017050800015035,2017050800015036,2017050800015037,2017050800015038,2017050800015039,2017050800015040,2017050800015041,2017050800015042,2017050800015043,2017050800015044,2017050800015045,2017050800015046,2017050800015047,2017050800015048,2017050800015049,2017050800015050,2017050800015051,2017050800015052,2017050800015053,2017050800015054,2017050800015055,2017050800015056,2017050800015057,2017050800015058,2017050800015059,2017050800015060,2017050800015061,2017050800015062,2017050800015063,2017050800015064,2017050800015065,2017050800015066,2017050800015067,2017050800015068,2017050800015069,2017050800015070,2017050800015071,2017050800015072,2017050800015073,2017050800015074,2017050800015075,2017050800015076,2017050800015077,2017050800015078,2017050800015079,2017050800015080,2017050800015081,2017050800015082,2017050800015083,2017050800015084,2017050800015085,2017050800015086,2017050800015087,2017050800015088,2017050800015089,2017050800015090,2017050800015091,2017050800015092,2017050800015093,2017050800015094,2017050800015095,2017050800015096,2017050800015097,2017050800015098,2017050800015099,2017050800015100,2017050800015101,2017050800015102,2017050800015103,2017050800015104,2017050800015105,2017050800015106,2017050800015107,2017050800015108,2017050800015109,2017050800015110,2017050800015111,2017050800015112,2017050800015113,2017050800015114,2017050800015115,2017050800015116)
