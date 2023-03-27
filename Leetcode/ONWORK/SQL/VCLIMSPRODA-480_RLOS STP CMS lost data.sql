--COPY CLOS COL - to SAUBMIT LIGHT CẢ with a COL
Search 'PT20130826007376'; --copy col

-- PROCESS: 
-- SEE FAC in CMS - all the INFORMATION
-- fill all the fields need to test LOST or not

-- GO RLOS-= pull DATA from CMS - Check if have that fields

-- Send back to CMS -

-- BEFORE and AFTER change code
-- EXPECTATION:
-- before : LOSSS DATA
-- after : NO LOSS

--CMS query
SELECT * FROM CMS_SECURITY WHERE SECURITY_NO = 'PT20130826007376' ;

SELECT * FROM CMS_SECURITY WHERE SECURITY_NO = 'PT20130826007376' ; -- 20130826000006887

SELECT * FROM CMS_PROPERTY WHERE cms_collateral_id = 20130826000006887 ;

-- then edit and save on UI

-- JS to add and select OPtion to UI valuerInGCMS
let z= document.getElementById('valuerInGCMS') ;
let y = document.getElementsByClassName("valuerInGCMS")[0];
let x = document.getElementsByName("valuerInGCMS")[0];
var option = document.createElement("option");
option.text = "Kiwi"; option.value="NH TCB";option.selected = 'selected';
x.add(option);

The transaction has been saved.
Your Transaction ID is 20230223000255518

-- done change CMS- RLOS on and pull




SELECT * FROM TRANSACTION tr WHERE tr.transaction_date > TRUNC(SYSDATE) ;

SELECT * FROM CMS_PROPERTY WHERE cms_collateral_id = 20140903002947915 ; 

SELECT * FROM CMS_STAGE_PROPERTY WHERE cms_collateral_id IN (SELECT STAGING_REFERENCE_ID FROM TRANSACTION WHERE TRANSACTION_TYPE = 'COL' AND REFERENCE_ID = 20140903002947915) ; 

-- NOT DONE SUCCESS
--RETEST 2 : 


-- COME to RLOS UI to SEE FIELD in CMS -> can EDIT or NOT
--TEST DONE SUCCESS
https://svn.integrosys.com/projects/vbcms/branches/CR2022


-- RLOS

SELECT * FROM LOS_CA ; 
SELECT * FROM LOS_COLL ;
--3001 Vehicle AB	AB102

SELECT * FROM LOS_COLL WHERE sec_sub_typ_code = 'AB102' ;

SELECT * FROM LOS_CA WHERE ID IN (SELECT CA_ID FROM LOS_COLL WHERE sec_sub_typ_code = 'AB102' ) ;

-- APP REF : 12498MO18000031


-- JS to add and select OPtion to UI valuerInGCMS
let x= document.getElementById('approveExceptionList') ;
let option1 = document.createElement("option");
let option2 = document.createElement("option");
option1.text = "Kiwi"; option1.value="NH TCB";option1.selected = 'selected';
option2.text = "VipCus2"; option2.value="NH TCB2";option2.selected = 'selected';
x.add(option1);x.add(option2);


-- 23/03 / Col copy from CLOS before STP  -- CREATE CAR 
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'MS607' ORDER BY cms_collateral_id DESC; 
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'MS606' ORDER BY cms_collateral_id DESC; 
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'MS706' ORDER BY cms_collateral_id DESC;  
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'MS709' ORDER BY cms_collateral_id DESC;  
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'MS610' ORDER BY cms_collateral_id DESC; 
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'MS700' ORDER BY cms_collateral_id DESC;  
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'MS601' ORDER BY cms_collateral_id DESC;  
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'PT703' ORDER BY cms_collateral_id DESC;  
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'GT408' ORDER BY cms_collateral_id DESC; 
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'OT900' ORDER BY cms_collateral_id DESC;  
SELECT cms_collateral_id, los_security_dtl_id , SECURITY_NO  FROM CMS_SECURITY WHERE security_sub_type_id = 'MS611' ORDER BY cms_collateral_id DESC; 
--20190123000029583	201901230000030331	MS201901230000030331   MS607
--20170220000028674	201703230000029332	MS201702200000029085  MS606
--20190611000029847	201904220000031294	MS201904220000031294   MS610
-- 20190123000029591	201901230000030335	MS201901230000030335   MS601
-- 20170220000028662	201703230000029322	PT201702200000029077   PT703
-- 20190123000029589	201901230000030334	GT201901230000030334   GT408
-- 20190618000029865	201906180000031505	OT201906180000031505   OT900
-- 20190123000029583	201901230000030331	MS201901230000030331    MS611

Type of CAR *	Personal Loan  
Application Number ^	CAR/23/0001/00122/00009331 

-- 27/03     Find COL type AB102 AB 110 to copy in CLOS

SELECT * FROM sml_collateral_group_map ;
SELECT * FROM SML_SEC_TYPE ;
SELECT * FROM SML_SEC_SUB_TYPE;

 FROM (SELECT doc.id AS id,
                                           doc.version_time AS version_time,
                                           doc.app_typ AS app_type,
                                           doc.los_fac_id AS los_fac_id,
                                           doc.los_coll_id AS los_coll_id,
                                           coll.source_security_sub_type AS coll_code,
                                           (SELECT type_code
                                              FROM sml_sec_type
                                             WHERE id = coll.type_id)
                                              AS sec_typ_code,
                                           (SELECT subtype_code
                                              FROM sml_sec_sub_type
                                             WHERE id = coll.subtype_id)
                                              AS sec_sub_typ_code,
                                           coll.security_location AS country_code,
                                           cou.ctr_cntry_name AS country_dscp
                                      FROM    sml_doc doc
                                           INNER JOIN
                                                 sml_security coll

AB102	Phương tiện vận tải	Phương tiện vận tải
AB110	Vàng	Vàng	AB

SELECT * FROM SML_SECURITY WHERE subtype_id = 10003 ORDER BY ID DESC;-- AB202005070000032321  VEHCLE
SELECT * FROM SML_SECURITY WHERE subtype_id = 10006 ORDER BY ID DESC;-- --COLLATERAL_NO = AB201901230000030329         VANG

SELECT * FROM SML_SECURITY ORDER BY ID DESC ;

NEW COL
202303270000032469      AB  - vehciel
202303270000032468      AB   gold
202303270000032467



Type of CAR *	Credit Card  
Application Number ^	CAR/23/0001/00122/00009327 

-- FIND in CMS after STP ;
SELECT * FROM CMS_SECURITY ORDER BY cms_collateral_id DESC;

20230327000030132	AB102	Phuong ti?n v?n t?i	Ð?ng s?n	VN	VND	0	VND	100000000										122	31-DEC-49	O			COL1			202303270000032469		AB102	AB		VND		ACTIVE	1					VND		I	122				N	3001		01-MAY-20	01-AUG-20	S					AB	27-MAR-23		CLOS		N	0								N																																																									a	1	hungdv				0.1		CG3		27-MAR-23				AB202303270000032469					12230
20230327000030130	AB110	Vàng	Ð?ng s?n	VN	VND	0	VND	100000000										122		O			123 AAAA			202303270000032468		AB110	AB		VND		ACTIVE	1					VND		I	122				N	6001		22-APR-19	22-JUN-19	S					AB	27-MAR-23		CLOS		N	0								N																																																									1	1	an.ph				0.03		CG3		27-MAR-23				AB202303270000032468					12230
20230327000030128	AB110	Vàng	Ð?ng s?n	VN	VND	0	VND	1560000000										122		O			COLL 1 - TEST INTERFACE RLOS&CLIMS			202303270000032466		AB110	AB		VND		ACTIVE	1					VND		I	122				N	6002		22-JAN-19	22-MAR-19	S					AB	27-MAR-23		CLOS		N	0								N																																																									Coll 1 - Test Interface RLOS&CLIMS	1	minhntt				0.12		CG3		27-MAR-23				AB202303270000032466					12230


-- RLOS VAR CHANGED TEST :
search CMS : AB202303270000032469 , AB202303270000032468

-- Work as wanted
