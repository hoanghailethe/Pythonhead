


UPDATE SCI_LE_SUB_PROFILE
SET CMS_SUB_ORIG_ORGANISATION ='166' 
WHERE cms_le_sub_profile_id  = (SELECT cms_customer_id FROM sci_lsp_lmt_profile WHERE los_bca_ref_num = 'CAR/22/9001/00166/05073008') ;
COMMIT ;

UPDATE SCI_LE_SUB_PROFILE
SET CMS_SUB_ORIG_ORGANISATION ='166' 
WHERE cms_le_sub_profile_id  = 20150515000077357 ;
COMMIT ;



--cMS 
SELECT DISTINCT CMS_SUB_ORIG_ORGANISATION FROM SCI_LE_SUB_PROFILE ;
SELECT COUNT(1) FROM SCI_LE_SUB_PROFILE WHERE CMS_SUB_ORIG_ORGANISATION LIKE '%--%' ;

SELECT * FROM sci_lsp_lmt_profile WHERE los_bca_ref_num = 'CAR/22/9001/00166/05073008' 

SELECT 
FROM SCI_LE_SUB_PROFILE a , sci_lsp_lmt_profile b 
WHERE b.cms_customer_id = a.cms_le_sub_profile_id 
AND b.los_bca_ref_num = 'CAR/22/9001/00166/05073008'  ;

SELECT COUNT(1) FROM SCI_LE_SUB_PROFILE WHERE CMS_SUB_ORIG_ORGANISATION LIKE '%--%' ;
SELECT * FROM SCI_LE_SUB_PROFILE WHERE CMS_SUB_ORIG_ORGANISATION LIKE '%--%' ORDER BY cms_le_sub_profile_id DESC;

SELECT * FROM COMMON_CODE_CATEGORY  WHERE category_id = 40 ;
SELECT * FROM COMMON_CODE_CATEGORY  WHERE category_type= 40   ;
SELECT * FROM COMMON_CODE_CATEGORY  WHERE category_name LIKE '%Branch%'   ;
SELECT * FROM COMMON_CODE_CATEGORY  WHERE category_code LIKE '%Branch%'   ;

SELECT * FROM COMMON_CODE_CATEGORY_ENTRY ;
SELECT * FROM COMMON_CODE_CATEGORY_ENTRY WHERE CATEGORY_CODE = '40';

-- CLOS
SELECT * FROM sml_customer ;
SELECT * FROM SML_CUSTOMER WHERE BRANCH_ID IS NULL ;

select cv.code from code_value cv where cv.id = 112920 ;

select cv.code from code_value cv where cv.code LIKE '%--%' ;


SELECT * FROM SML_CUSTOMER WHERE CIF_NUMBER = '0000000000300036260';


-- tìm customer bên clos là theo CIF_NUMBER trong bảng SML_CUSTOMER  
-- cho bằng LLP_LE_ID trong sci_lsp_lmt_profile theo số CAR 


-- 180423

SELECT  * FROM SCI_LE_SUB_PROFILE WHERE LSP_LE_ID = '700005433';

SELECT * FROM sci_lsp_lmt_profile WHERE LLP_LE_ID = '700005433';


SELECT  * FROM SCI_LE_SUB_PROFILE WHERE cms_sub_orig_organisation = '--' ORDER BY cms_le_sub_profile_id DESC;

SELECT * FROM sci_lsp_lmt_profile WHERE CMS_CUSTOMER_ID IN (20200604000003583,
20200529000003582,
20200520000003581,
20200506000003580,
20160415000003254,
20160415000003253) ;

SELECT a.* FROM sci_lsp_lmt_profile a ,SCI_LE_SUB_PROFILE b WHERE
a.CMS_CUSTOMER_ID=
b.CMS_LE_SUB_PROFILE_ID
AND
b.cms_le_main_profile_id IN (
20130605000000024,
20130605000000025,
20130605000000026,
20130605000000027,
20130605000000028,
20130605000000029,
20130606000000036) ; 


SELECT a.* FROM sci_lsp_lmt_profile a ,SCI_LE_SUB_PROFILE b WHERE
a.CMS_CUSTOMER_ID=
b.CMS_LE_SUB_PROFILE_ID
AND
b.cms_sub_orig_organisation not like '%--%' ; 

SELECT a.* FROM STAGE_LIMIT_PROFILE a ,SCI_LE_SUB_PROFILE b WHERE
a.CMS_CUSTOMER_ID=
b.CMS_LE_SUB_PROFILE_ID
AND
b.cms_sub_orig_organisation not like '%--%' ; 

SELECT a.* FROM STAGE_LIMIT_PROFILE a WHERE a.cms_orig_organisation = '--' ;
SELECT * FROM stage_sub_profile WHERE cms_orig_organisation = '--' ;

SELECT (COUNT(1)) FROM sci_lsp_lmt_profile a ,SCI_LE_SUB_PROFILE b
WHERE
a.CMS_CUSTOMER_ID=
b.CMS_LE_SUB_PROFILE_ID
AND
b.cms_sub_orig_organisation  like '%--%' GROUP BY b.CMS_LE_SUB_PROFILE_ID; -- 5703   2955

SELECT COUNT(1) FROM SCI_LE_SUB_PROFILE ; --3568
SELECT COUNT(1) FROM SCI_LE_SUB_PROFILE WHERE cms_sub_orig_organisation like '%--%' ; --35

SELECT * FROM sci_lsp_lmt_profile WHERE cms_orig_organisation = '--';

SELECT * FROM cms_aa_pending_perfection WHERE cms_orig_organisation LIKE '%--%';


SELECT * FROM CMS_STAGE_TAT_DOCUMENT ;


SELECT * 
FROM cms_user WHERE roletype_id = 8 ;

SELECT * 
FROM cms_user A
JOIN CMS_TEAM_MEMBER B ON A.USER_ID = B.USER_ID 
JOIN CMS_TEAM_MEMBERSHIP C ON b.team_membership_id = c.team_membership_id
JOIN CMS_TEAM_TYPE_MEMBERSHIP D ON c.team_type_membership_id = d.team_type_membership_id
JOIN CMS_TEAM_TYPE E ON D.TEAM_TYPE_ID = E.TEAM_TYPE_ID
WHERE LOGIN_ID= 'CSAMHA01';

UPDATE CMS_TEAM_MEMBERSHIP SET team_type_membership_id = 10 WHERE team_membership_id = 20151021000006003 ; 
COMMIT ;

SELECT C.* 
FROM cms_user A
JOIN CMS_TEAM_MEMBER B ON A.USER_ID = B.USER_ID 
JOIN CMS_TEAM_MEMBERSHIP C ON b.team_membership_id = c.team_membership_id
JOIN CMS_TEAM_TYPE_MEMBERSHIP D ON c.team_type_membership_id = d.team_type_membership_id
JOIN CMS_TEAM_TYPE E ON D.TEAM_TYPE_ID = E.TEAM_TYPE_ID
WHERE c.team_type_membership_id = 8;

SELECT a.* FROM sci_lsp_lmt_profile a ,SCI_LE_SUB_PROFILE b WHERE
a.CMS_CUSTOMER_ID=
b.CMS_LE_SUB_PROFILE_ID
AND
b.cms_sub_orig_organisation not like '%--%' ; 

SELECT a.* FROM STAGE_LIMIT_PROFILE a ,SCI_LE_SUB_PROFILE b WHERE
a.CMS_CUSTOMER_ID=
b.CMS_LE_SUB_PROFILE_ID
AND
b.cms_sub_orig_organisation not like '%--%' ; 

SELECT a.* FROM STAGE_LIMIT_PROFILE a WHERE a.cms_orig_organisation = '--' ;
SELECT * FROM stage_sub_profile WHERE cms_orig_organisation = '--' ;

SELECT (COUNT(1)) FROM sci_lsp_lmt_profile a ,SCI_LE_SUB_PROFILE b
WHERE
a.CMS_CUSTOMER_ID=
b.CMS_LE_SUB_PROFILE_ID
AND
b.cms_sub_orig_organisation  like '%--%' GROUP BY b.CMS_LE_SUB_PROFILE_ID; -- 5703   2955

SELECT COUNT(1) FROM SCI_LE_SUB_PROFILE ; --3568
SELECT COUNT(1) FROM SCI_LE_SUB_PROFILE WHERE cms_sub_orig_organisation like '%--%' ; --35

SELECT * FROM sci_lsp_lmt_profile WHERE cms_orig_organisation = '--';

SELECT * FROM cms_aa_pending_perfection WHERE cms_orig_organisation LIKE '%--%';


SELECT * FROM sci_le_sub_profile WHERE lsp_le_id = '0000000000800000518';
UPDATE sci_le_sub_profile SET cms_sub_orig_organisation = NULL WHERE cms_le_sub_profile_id = 20200427000003578 ; 
COMMIT ;

SELECT * FROM sci_le_sub_profile WHERE cms_sub_orig_organisation IS NULL ;



SELECT * FROM CMS_STAGE_TAT_DOCUMENT ;


SELECT * 
FROM cms_user WHERE roletype_id = 8 ;

SELECT * 
FROM cms_user A
JOIN CMS_TEAM_MEMBER B ON A.USER_ID = B.USER_ID 
JOIN CMS_TEAM_MEMBERSHIP C ON b.team_membership_id = c.team_membership_id
JOIN CMS_TEAM_TYPE_MEMBERSHIP D ON c.team_type_membership_id = d.team_type_membership_id
JOIN CMS_TEAM_TYPE E ON D.TEAM_TYPE_ID = E.TEAM_TYPE_ID
WHERE LOGIN_ID= 'CSAMHA01';

UPDATE CMS_TEAM_MEMBERSHIP SET team_type_membership_id = 10 WHERE team_membership_id = 20151021000006003 ; 
COMMIT ;

SELECT A.* 
FROM cms_user A
JOIN CMS_TEAM_MEMBER B ON A.USER_ID = B.USER_ID 
JOIN CMS_TEAM_MEMBERSHIP C ON b.team_membership_id = c.team_membership_id
JOIN CMS_TEAM_TYPE_MEMBERSHIP D ON c.team_type_membership_id = d.team_type_membership_id
JOIN CMS_TEAM_TYPE E ON D.TEAM_TYPE_ID = E.TEAM_TYPE_ID
WHERE c.team_type_membership_id = 8;



SELECT * FROM SCI_LE_MAIN_PROFILE ;

SELECT MAINI.* FROM SCI_LE_MAIN_PROFILE MAINI , sci_le_sub_profile SUBI WHERE
SUBI.cms_sub_orig_organisation = '--'
AND MAINI.CMS_LE_MAIN_PROFILE_ID = SUBI.CMS_LE_MAIN_PROFILE_ID ;

SELECT * FROM SCI_PLEDGOR_DTL WHERE CMS_ORIG_ORGANISATION = '--';
VN	--	CLOS
VN	--	CLOS
VN	--	CLOS
MY	--	CLOS
MY	--	CLOS
VN	--	CLOS
VN	--	CLOS

SELECT * FROM sci_le_sub_profile WHERE lsp_le_id = '1283' ;
-- 20170529000003541	1	1283			VN																																						U				Y			20170529000003539			VN	144	Y				

UPDATE sci_le_sub_profile SET CMS_SUB_ORIG_ORGANISATION = NULL WHERE  cms_le_sub_profile_id = 20170529000003541 ;
COMMIT ;

SELECT * FROM sci_le_sub_profile WHERE lsp_le_id = '128318042023';


SELECT * FROM sci_le_sub_profile WHERE lsp_le_id = '400210934' ;

--CMS  ABOVE

--CLOS BELOW

SELECT  * FROM  SML_CUSTOMER WHERE CIF_NUMBER IN(3023911740,3022759952,3000825743,3023763635,2200281691,400505962);

