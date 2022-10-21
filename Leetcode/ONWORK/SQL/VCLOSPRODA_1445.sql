CMS_SECURITY
CMS_STAGE_SECURITY
CMS_LIMIT_SECURITY_MAP
CMS_STAGE_SECURITY_MAP

--18/10/22
SELECT * FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%';
SELECT * FROM CMS_STAGE_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%';


SELECT * FROM CMS_LIMIT_SECURITY_MAP WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%') ;
SELECT * FROM CMS_STAGE_LIMIT_SECURITY_MAP WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_STAGE_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%') ;


SELECT * FROM CMS_LIMIT_CHARGE_MAP WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%') ;
SELECT * FROM CMS_STAGE_LIMIT_CHARGE_MAP WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_STAGE_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%') ;

--19/10/22
SELECT * FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';
SELECT * FROM CMS_STAGE_SECURITY WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';

SELECT * FROM CMS_SECURITY WHERE SECURITY_NO LIKE '%PT20140903725907%';

SELECT * FROM CMS_LIMIT_SECURITY_MAP WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';
SELECT * FROM CMS_STAGE_LIMIT_SECURITY_MAP WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';

SELECT * FROM CMS_LIMIT_CHARGE_MAP WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%' ;
SELECT * FROM CMS_STAGE_LIMIT_CHARGE_MAP WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%' ;

SELECT * FROM CMS_PROPERTY WHERE  CMS_COLLATERAL_ID LIKE '%20220323019759604%' ;
SELECT * FROM CMS_STAGE_PROPERTY WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';

SELECT * FROM CMS_CA_COLLATERAL_MAP WHERE SECURITY_NO IN ('PT20140903725907', 'PT202203230021586339' );

20220323019759604
--20/10
SELECT * FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00610/05021749%' ;
SELECT existing_ind,cc.* FROM SML_CA_COLLATERAL cc WHERE CA_ID IN (SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00610/05021749%'  );
SELECT * FROM CODE_VALUE WHERE CODE LIKE '%VARIATION_AA%';

Current User:   [ rm106dat (Dat), id: 20130903004976 (20130826004861), role: RM (Relationship Manager), profile id: 20130826005868 ]
Team:           [ RM106DAT (20130826001038) ]
Request Path:   [ ReferApprovalFolder.do?event=refer_approval ]
Referrer:       [ http://localhost:8081/clos/ApprovalFolder.do ]
ActionForm:     [ ReferralInstructionForm, class: com.integrosys.sml.ui.los.fpapproval.ReferralInstructionForm ]
ActionForward:  [ refer_approval, path: /template/common_template.jsp ]
Title:          [ Approval Folder ]
Right Frame:    [ /los/fpapproval/refer_approval.jsp ]


--new test
clos
SELECT * FROM CMS_SECURITY WHERE SECURITY_NO = 'PT20130826007376' ;
-- CMS_COL_ID :     

SELECT CLS.*
FROM CMS_LIMIT_SECURITY_MAP CLS 
INNER JOIN CMS_SECURITY CS ON CLS.CMS_COLLATERAL_ID = CS.CMS_COLLATERAL_ID AND cls.cms_collateral_id = 20130826000006887; 

SELECT * FROM SML_SECURITY WHERE collateral_no = 'PT20130826007376' ;
--Create by rm106dat   cola_ ID = 20130828007624
--id submit to approve to : 20130826004863
SELECT * FROM SML_USER WHERE ID = 20130826004863 ; -- CA106DAT


SELECT * FROM sml_ca_collateral WHERE collateral_id = 20130828007624;
SELECT * FROM sml_ca_collateral  coca JOIN SML_SECURITY sec ON coca.collateral_id = sec.id AND sec.collateral_no = 'PT20130826007376' 
AND coca.ca_id = 20130829004072 ;

--CA_ID 20130828003984
SELECT * FROM SML_CA WHERE ID = 20130828003984;
-- CAR/13/0001/00106/0000801-003
--CAR/13/0001/00106/0000801-008
SELECT * FROM SML_CA WHERE CA_NUMBER = 'CAR/13/0001/00106/0000801-008'; --id 20130829004072

--FAC
--"FROM sml_ca fp  " + "inner join sml_facility fac ON fac.ca_id = fp.id " +
SELECT * FROM SML_FACILITY fac JOIN SML_CA fp ON fac.ca_id = fp.id AND fp.id = 20130828003984;

-- CLIMS 
SELECT * FROM CMS_PROPERTY WHERE independent_valuer_flag IS NULL AND abandoned_project IS NULL;
-- CMS_COLLATERAL ID
--20200413000029877
--20200413000029879
--20200614000030066
--20200604000030039
--20200614000030064
--20200614000030062
--20200615000030068

SELECT * FROM CMS_SECURITY WHERE cms_collateral_id IN (20200413000029877,20200413000029879,20200614000030066,20200604000030039,20200614000030064,20200614000030062,20200615000030068) ;

SELECT * FROM cms_ca_collateral_map WHERE cms_collateral_id IN (20200413000029877,20200413000029879,20200614000030066,20200604000030039,20200614000030064,20200614000030062,20200615000030068) ;

ROLLBACK;

patch data this
--20130827000000024	20130826000001679	20130826000006887	CAR/13/0001/00106/0000801-008	20130829007886	PT20130826007376	1
SELECT * FROM cms_ca_collateral_map WHERE SECURITY_NO = 'PT20130826007376' ;
SELECT * FROM CMS_SECURITY WHERE cms_collateral_id = 20130826000006887 ;

SELECT * FROM CMS_PROPERTY WHERE cms_collateral_id = 20130826000006887 ;



--after STP 
    SELECT * FROM cms_ca_collateral_map WHERE security_no like  '%PT202210200000032441%';
SELECT * FROM SML_SECURITY WHERE COLLATERAL_NO LIKE '%PT202210200000032441%';     
--202210200000032441	1	rm106dat	20-OCT-22	rm106dat	20-OCT-22	10029
    SELECT * FROM cms_ca_collateral_map WHERE cms_collateral_id = 202210200000032441;
SELECT * FROM CMS_PROPERTY WHERE cms_collateral_id = 202210200000032441 ;

--new car at night
Current User:   [ rmklinh001 (rmklinh001), id: 201509210000009673 (201509210000009666), role: RM (Relationship Manager), profile id: 201509210000010709 ]
Team:           [ RMKLINH001 TEAM (201509210000001480) ]
Request Path:   [ ListFPGenTNC.do?event=create_ter_n_con ]
Referrer:       [ http://localhost:8081/clos/ListFPGenTNC.do ]
ActionForm:     [ ListFinancialPackageTNCForm, class: com.integrosys.sml.ui.los.financialpackage.fptnc.ListFinancialPackageTNCForm ]
ActionForward:  [ save_ack, path: /template/common_template.jsp ]
Title:          [ Financial Package (Terms N Conditions) ]
Right Frame:    [ /common/common_ack.jsp ]
Left Frame:     [ Terms and Conditions ]
Table Load:     [ SML_FP_TNC (18), SML_PROD_PACKAGE (1), SML_USER_SESSION (1) ]
Table Insert:   [ SML_FP_TNC (9) ]
IPin Class:     [ com.integrosys.sml.ui.los.customer.CustomerAction ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.session.pp_productKey, type: com.integrosys.sml.app.productpackage.product.vo.OBProductPackageProduct (SML_PROD_PKG_PRODUCT), id: 201608090000001217, version: 0 ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.session.customerKey, type: com.integrosys.sml.app.customer.vo.OBCompanyCustomer (SML_COMPANY_CUSTOMER), id: 201703310000006114, version: 1 ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.serviceColObj, type: com.integrosys.sml.app.collateral.vo.property.OBPropertyCollateral (SML_SEC_PT), id: 202210200000032444, version: 4 ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.sessions.amFacAccRelationship, type: com.integrosys.sml.app.facility.vo.OBFacilityAcctRelationship (SML_FAC_ACCT_RELATIONSHIP), id: 202210200000037455, version: 0 ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.session.aaLimitKey, type: com.integrosys.sml.app.aalimit.vo.OBAALimit (SML_AA_LIMIT), id: 202210200000020964, version: 0 ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.session.facilityDetailsKey, type: com.integrosys.sml.app.financialpackage.vo.OBFinancialPackage (SML_CA), id: 202210200000023706, version: 4 ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.session.exposureKey, type: com.integrosys.sml.app.exposure.vo.OBExposure (SML_CA_EXPOSURE), id: 202210200000014400, version: 1 ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.session.facilityKey, type: com.integrosys.sml.app.facility.vo.OBFacility (SML_FACILITY), id: 202210200000042778, version: 0 ]
Value Object:   [ session key: com.integrosys.sml.ui.los.customer.CustomerAction.session.financialPackageKey, type: com.integrosys.sml.app.financialpackage.vo.OBFinancialPackage (SML_CA), id: 202210200000023706, version: 4 ]
Customer:       [ id: 201703310000006114, name: BENH VIEN DA KHOA DONG DA, cif: 3013861030 ]
CAR:            [ id: 202210200000023706, number: CAR/22/0001/00122/00009313, status: DRAFT ]

SELECT * FROM sml_security WHERE collateral_no = 'PT20130826007376'; --copy col

PTCLOS: PT202210200000032444   == new col
Loại CAR *	H? so tín d?ng thông thu?ng - SXKD  
Số hồ sơ ^	CAR/22/0001/00122/00009313 

Type of CAR *	Mortgage  
Application Number ^	CAR/22/0001/00122/00009314 
PT202210210000032445

--21/10/22
Type of CAR *	Mortgage  
Application Number ^	CAR/22/0001/00122/00009314 
PT202210210000032445
--clims
    SELECT * FROM cms_ca_collateral_map WHERE security_no like  '%PT202210210000032445%';
SELECT * FROM CMS_SECURITY WHERE SECURITY_NO LIKE '%PT202210210000032445%';     --id : 20221021000030093
--202210200000032441	1	rm106dat	20-OCT-22	rm106dat	20-OCT-22	10029
    SELECT * FROM cms_ca_collateral_map WHERE cms_collateral_id = 20221021000030093;
SELECT * FROM CMS_PROPERTY WHERE cms_collateral_id = 20221021000030093 ;
-- GOOD DONE


-- query change history
SELECT * FROM TRANSACTION tr WHERE tr.transaction_date BETWEEN TRUNC(SYSDATE - 2) AND TRUNC(SYSDATE) - 1/86400 ;

SELECT * FROM CMS_PROPERTY WHERE cms_collateral_id = 20140903002947915 ; 

SELECT * FROM CMS_STAGE_PROPERTY WHERE cms_collateral_id IN (SELECT STAGING_REFERENCE_ID FROM TRANSACTION WHERE TRANSACTION_TYPE = 'COL' AND REFERENCE_ID = 20140903002947915) ; 

SELECT * FROM TRANSACTION WHERE TRANSACTION_TYPE = 'COL' AND REFERENCE_ID = 20140903002947915;

SELECT * FROM TRANS_HISTORY WHERE transaction_type = 'COL' AND reference_id  = 20140903002947915; 
SELECT * FROM TRANS_HISTORY WHERE transaction_id IN (SELECT TRANSACTION_ID FROM TRANSACTION WHERE TRANSACTION_TYPE = 'COL' AND REFERENCE_ID = 20140903002947915); 

SELECT * FROM CMS_SECURITY WHERE cms_collateral_id = 20140903002947915 ; 
SELECT * FROM CMS_STAGE_SECURITY WHERE cms_collateral_id IN (SELECT STAGING_REFERENCE_ID FROM TRANSACTION WHERE TRANSACTION_TYPE = 'COL' AND REFERENCE_ID = 20140903002947915) ; 


--test before query with : 20221020000030091 cms_col_id


