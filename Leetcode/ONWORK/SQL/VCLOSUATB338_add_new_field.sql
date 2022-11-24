INSERT INTO COMMON_CODE_CATEGORY (
        CATEGORY_ID,
        CATEGORY_CODE,
        CATEGORY_NAME,
        CATEGORY_TYPE,
        ACTIVE_STATUS, 
        VERSION_TIME
    )
VALUES (
        COMMON_CODE_CATEGORY_SEQ.nextval,
        'APPROVAL_EXCEPTIONAL',
        'Approval Exceptional',
        2,
        'A',
        1
    );
insert into common_code_category_entry (
        entry_id,  
        entry_code,
        entry_name,
        locale_name1,
        active_status,
        country,
        category_code,
        category_code_id,
        VERSION_TIME
    )
select common_code_category_entry_seq.nextval,
    'VP1',
    'VIP CUSTOMER 1',
    '1',
    'A',
    'VN',
    category_code,
    category_id,
    VERSION_TIME
from common_code_category
where category_code = 'APPROVAL_EXCEPTIONAL';

insert into common_code_category_entry (
        entry_id,  
        entry_code,
        entry_name,
        locale_name1,
        active_status,
        country,
        category_code,
        category_code_id,
        VERSION_TIME
    )
select common_code_category_entry_seq.nextval,
    'VP2',
    'VIP CUSTOMER 2',
    '1',
    'A',
    'VN',
    category_code,
    category_id,
    VERSION_TIME
from common_code_category
where category_code = 'APPROVAL_EXCEPTIONAL';

--added 112122
-- STAGING TABLE

insert into STAGE_COMMON_CODE_CATEGORY (category_id, category_code, category_name, category_type, active_status, VERSION_TIME)
select common_code_category_seq.nextval, category_code, category_name, category_type, active_status, VERSION_TIME 
from COMMON_CODE_CATEGORY where category_code ='APPROVAL_EXCEPTIONAL';

insert into stage_common_code_entry
(stage_id, entry_id, entry_code, entry_name, active_status, category_code, category_code_id, entry_source, country, group_id,
    ref_entry_code, staging_reference_id, is_new)
(select COMM_CODE_ENTRY_STG_SEQ.nextval, ccce.ENTRY_ID, ccce.entry_code, ccce.entry_name, ccce.ACTIVE_STATUS, ccce.CATEGORY_CODE,
    ccce.CATEGORY_CODE_ID, ccce.ENTRY_SOURCE, ccce.country, ccce.GROUP_ID, ccce.REF_ENTRY_CODE, ccce.CATEGORY_CODE_ID, 'Y'
from common_code_category_entry ccce, common_code_category ccc
where ccc.category_code = ccce.CATEGORY_CODE and ccce.CATEGORY_CODE in ('APPROVAL_EXCEPTIONAL'));


--TRANSTACTION
INSERT INTO TRANSACTION (
        TRANSACTION_ID,
        FROM_STATE,
        USER_ID,
        TRANSACTION_TYPE,
        REFERENCE_ID,
        STATUS,
        TEAM_ID,
        TRX_REFERENCE_ID,
        LEGAL_ID,
        CUSTOMER_ID,
        LIMIT_PROFILE_ID,
        TEAM_TYPE_ID,
        TO_GROUP_TYPE_ID,
        TO_GROUP_ID,
        TO_USER_ID
    )
SELECT TS_FMT(CURRENT_TIMESTAMP, 'yyyymmdd') || lpad(TRX_SEQ.nextval, 9, '0'),
    'ND',
    -999999999,
    'COMMON_CODE_TYPE',
    C.CATEGORY_ID,
    'ACTIVE',
    20040319000116,
    -999999999,
    '-999999999',
    -999999999,
    -999999999,
    2,
    TO_CHAR(-999999999),
    -999999999,
    -999999999
FROM COMMON_CODE_CATEGORY C
WHERE CATEGORY_CODE in ('APPROVAL_EXCEPTIONAL');
--TRANS for CODE ENTRY
INSERT INTO TRANSACTION 
(TRANSACTION_ID, FROM_STATE, USER_ID, 
TRANSACTION_TYPE, REFERENCE_ID, STAGING_REFERENCE_ID, STATUS, 
TEAM_ID, TRX_REFERENCE_ID, 
LEGAL_ID, CUSTOMER_ID, LIMIT_PROFILE_ID, TEAM_TYPE_ID, 
TO_GROUP_TYPE_ID, TO_GROUP_ID, TO_USER_ID)
SELECT TS_FMT(CURRENT_TIMESTAMP, 'yyyymmdd') || lpad(TRX_SEQ.nextval,9,'0'),
'PENDING_CREATE', -999999999, 'COMMON_CODE_ENTRY', C.CATEGORY_ID, C.CATEGORY_ID, 'ACTIVE', 
20040319000116,-999999999,'-999999999',
-999999999,-999999999, 2,
TO_CHAR(-999999999),-999999999,-999999999
FROM COMMON_CODE_CATEGORY C 
WHERE CATEGORY_CODE in ('APPROVAL_EXCEPTIONAL');

-- TEST: QUERY
SELECT * FROM CMS_SECURITY ; 

SELECT * FROM CMS_SECURITY WHERE cms_collateral_id = 20210324014203802 ;
SELECT * FROM CMS_SECURITY WHERE cms_collateral_id = 20130606000000007 ;

SELECT * FROM CMS_USER WHERE LOGIN_ID LIKE '%SYS%'; 

SELECT * FROM TRANSACTION WHERE REFERENCE_ID IN (28, 542) and TRANSACTION_TYPE = 'COMMON_CODE_TYPE' ;
SELECT * FROM TRANSACTION WHERE REFERENCE_ID IN (28, 542) and TRANSACTION_TYPE = 'COMMON_CODE_ENTRY' ;
SELECT * FROM stage_common_code_entry WHERE CATEGORY_CODE in ('APPROVAL_EXCEPTIONAL') ; 

SELECT * FROM COMMON_CODE_CATEGORY WHERE CATEGORY_CODE = 'APPROVAL_EXCEPTIONAL' ;


== SEARCH TEST CLIMS
SELECT * FROM stage_common_code_entry ;

SELECT * FROM COMMON_CODE_CATEGORY WHERE category_code = 'APPROVAL_EXCEPTIONAL';
--542	APPROVAL_EXCEPTIONAL	Approval Exceptional	1	A	1			
SELECT * FROM common_code_category_entry WHERE category_code = 'APPROVAL_EXCEPTIONAL';
612153	Ex1
612154	Ex2

== 1121 == fix in cms maintant category code
SYSTEM ADMIN : SYS_MAKER

-- find similar  DATA
SELECT * FROM TRANSACTION WHERE REFERENCE_ID = 28 and TRANSACTION_TYPE = 'COMMON_CODE_TYPE' ;

-- CLOS
ALTER TABLE ADD APPROVAL_EXCEPTION varchar(255);

INSERT INTO COMMON_CODE_CATEGORY (
        CATEGORY_ID,
        CATEGORY_CODE,
        CATEGORY_NAME,
        CATEGORY_TYPE,
        ACTIVE_STATUS
    )
VALUES (
        COMMON_CODE_CATEGORY_SEQ.NEXTVAL,
        'APPROVAL_EXCEPTIONAL',
        'Approval Exceptional',
        1,
        'A'
    );
 INSERT INTO common_code_category_entry
            (entry_id,
             entry_code,
            --  ref_entry_code,
             entry_name,
             active_status,
             category_code,
             category_code_id)
(SELECT common_code_category_entry_seq.NEXTVAL,
        'Ex1', -- ??
        -- 'MS601', --?? 
        'VIP CUS 1', --?
        '1', --?
        category_code,
        category_id
 FROM   common_code_category
 WHERE  category_code = 'APPROVAL_EXCEPTIONAL');


--draft
   <sql-query name="HQL.borrower.search.postCode" resultset-ref="postcode.result">
    <![CDATA[  	
		SELECT ENTRY_NAME AS CITY, REF_ENTRY_CODE AS STATE
		FROM COMMON_CODE_CATEGORY_ENTRY
    	WHERE CATEGORY_CODE = 'CITY'
    	AND ENTRY_CODE= :postCode
    ]]>
    </sql-query>

    (SELECT entry_name
                            FROM   common_code_category_entry
                            WHERE  category_code = 'FAC_RATE'
                            AND entry_code = CFMTF.rate_num
                            AND ref_entry_code = (SELECT lmt_crrncy_iso_code
                                                    FROM   sci_lsp_appr_lmts
                                                    WHERE  cms_lsp_appr_lmts_id = :cmsFacMasterId and rownum = 1)) as rate_num ;

--CLIMS
INSERT INTO COMMON_CODE_CATEGORY (
        CATEGORY_ID,
        CATEGORY_CODE,
        CATEGORY_NAME,
        CATEGORY_TYPE,
        ACTIVE_STATUS
    )
VALUES (
        COMMON_CODE_CATEGORY_SEQ.NEXTVAL,
        'APPROVAL_EXCEPTIONAL',
        'Approval Exceptional',
        2,
        'A'
    );
    --INSERT SOME DUMMY NEW CODE DATA TO TEST 
 INSERT INTO common_code_category_entry
            (entry_id,
             entry_code,
            --  ref_entry_code,
             entry_name,
             active_status,
             category_code,
             category_code_id)
(SELECT common_code_category_entry_seq.NEXTVAL,
        'Ex1', 
        'VIP CUS 1', 
        '1', 
        category_code,
        category_id
 FROM   common_code_category
 WHERE  category_code = 'APPROVAL_EXCEPTIONAL');

 INSERT INTO common_code_category_entry
            (entry_id,
             entry_code,
             entry_name,
             active_status,
             category_code,
             category_code_id)
(SELECT common_code_category_entry_seq.NEXTVAL,
        'Ex2', 
        'VIP CUS 2', 
        '1', 
        category_code,
        category_id
 FROM   common_code_category
 WHERE  category_code = 'APPROVAL_EXCEPTIONAL');
 INSERT INTO common_code_category_entry
            (entry_id,
             entry_code,
             entry_name,
             active_status,
             category_code,
             category_code_id)
(SELECT common_code_category_entry_seq.NEXTVAL,
        'Ex3', 
        'VIP CUS 3', 
        '1', 
        category_code,
        category_id
 FROM   common_code_category
 WHERE  category_code = 'APPROVAL_EXCEPTIONAL');

-- TEST DATA LOCAL CLOS 1 

ALTER TABLE SML_FACILITY ADD APPROVAL_EXCEPTION varchar(255);

UPDATE COMMON_CODE_CATEGORY SET CATEGORY_TYPE = 2 WHERE CATEGORY_CODE = 'APPROVAL_EXCEPTIONAL' ; 

--grant pri
GRANT
  SELECT,
  INSERT,
  UPDATE,
  DELETE
ON
  common_code_category_entry, COMMON_CODE_CATEGORY
TO
  vbclos;

  --FAC id test CLOS
  getProductSearchResultByFacId facId >>>>>>:201901310000001267
  SELECT * FROM SML_FACILITY WHERE FAC_NO = 2019021300015727;

UPDATE SML_FACILITY SET APPROVAL_EXCEPTION = 'Ex2' WHERE FAC_NO = 2019021300015727; \
COMMIT;

I CREATED 
2022111400016097
FAC NO

SELECT * FROM SML_FACILITY WHERE FAC_NO = 2019021300015727;
UPDATE SML_FACILITY SET APPROVAL_EXCEPTION = 'Ex2' WHERE FAC_NO = 2019021300015727; 
COMMIT;

SELECT * FROM SML_FACILITY WHERE FAC_NO = 2022111400016097;
--test done : GOOD

--141122
move to table credit decision
OBCreditDecision
SML_FAC_CRED_DECISION
<many-to-one name="facility" column="FACILITY_ID"

ALTER TABLE SML_FAC_CRED_DECISION ADD APPROVAL_EXCEPTION varchar(255); 

    SELECT * FROM 
    SML_FAC_CRED_DECISION
    WHERE FACILITY_ID = (SELECT ID FROM SML_FACILITY WHERE FAC_NO = 2022111400016097);

    SELECT * FROM SML_FACILITY WHERE FAC_NO = 2022111400016097;

-- ADD to AA SCREEN
ALTER TABLE SML_AA_LIMIT_BANK_PROP ADD APPROVAL_EXCEPTION varchar(255);

--11/17 / CMS fix again
-- ADD TRANSACTION
insert into stage_common_code_entry
(stage_id, entry_id, entry_code, entry_name, active_status, category_code, category_code_id, entry_source, country, group_id,
    ref_entry_code, staging_reference_id, is_new)
(select COMM_CODE_ENTRY_STG_SEQ.nextval, ccce.ENTRY_ID, ccce.entry_code, ccce.entry_name, ccce.ACTIVE_STATUS, ccce.CATEGORY_CODE,
    ccce.CATEGORY_CODE_ID, ccce.ENTRY_SOURCE, ccce.country, ccce.GROUP_ID, ccce.REF_ENTRY_CODE, ccce.CATEGORY_CODE_ID, 'Y'
from common_code_category_entry ccce, common_code_category ccc
where ccc.category_code = ccce.CATEGORY_CODE and ccce.CATEGORY_CODE in ('APPROVAL_EXCEPTIONAL'));

INSERT INTO TRANSACTION 
(TRANSACTION_ID, FROM_STATE, USER_ID, 
TRANSACTION_TYPE, REFERENCE_ID, STATUS, 
TEAM_ID, TRX_REFERENCE_ID, LEGAL_ID, 
CUSTOMER_ID, LIMIT_PROFILE_ID, TEAM_TYPE_ID, 
TO_GROUP_TYPE_ID, TO_GROUP_ID, TO_USER_ID
)
SELECT TS_FMT(CURRENT_TIMESTAMP, 'yyyymmdd') || lpad(TRX_SEQ.nextval,9,'0'),
'ND', -999999999, 
'COMMON_CODE_TYPE', C.CATEGORY_ID, 'ACTIVE', 
20040319000116 , -999999999,'-999999999',
-999999999,-999999999, 2,
TO_CHAR(-999999999),-999999999,-999999999
FROM COMMON_CODE_CATEGORY C 
WHERE CATEGORY_CODE in ('APPROVAL_EXCEPTIONAL');-- co ve proc update ở đây rùi
CREATE OR REPLACE PROCEDURE proc_update_code_set_value
AS
BEGIN

== CLOS == get val from code_Set and code_value


SELECT * FROM CODE_SET ;
SELECT * FROM CODE_VALUE ;

begin
  proc_update_code_set_value();
end;

SELECT * FROM CODE_SET WHERE CODE LIKE '%APPROVAL_EXCEPTION%';

SELECT * FROM CODE_VALUE WHERE CODE_SET_VALUE_ID IN (SELECT ID FROM CODE_SET WHERE CODE LIKE '%APPROVAL_EXCEPTION%') ;

use substitute from code_value ; 

Sample query:
(SELECT cv.id FROM code_value cv 
INNER JOIN code_set cs ON cv.code_set_value_id = cs.id 
    AND cs.status = 'ACTIVE'
    AND cs.deprecated = 'N'
    AND cs.master_id IS NULL
    AND cv.status = 'ACTIVE'
    AND cv.deprecated = 'N'
    AND cv.master_id IS NULL
WHERE cs.code = '40' AND cv.code = t1.aa_branch_code)

-- 111822
SELECT * FROM CODE_VALUE WHERE CODE_SET_VALUE_ID IN (SELECT ID FROM CODE_SET WHERE CODE LIKE '%TREASURY_ISSUE_LIMIT%') ;

<sql-query name="getCodeValueListByCodeSetCode.Query" resultset-ref="getCodeValueListByCodeSetCode.Result">
		<![CDATA[
            SELECT val.ID, val.CODE, val.CODE_VALUE
                FROM   code_value val
                WHERE val.code_set_value_id IN (SELECT id
                                                FROM   code_set
                                                WHERE  code = :codeSetcode
                                                       AND deprecated = 'N'
                                                       AND status = 'ACTIVE'
                                                       AND master_id IS NULL) AND val.STATUS = 'ACTIVE'

        ]]>

--data test clos
-- MASTER_ID ??
-- DEPRECATE

INSERT INTO CODE_SET (ID, VERSION_TIME,  CREATE_BY, CREATION_DATE, LAST_UPDATE_BY, LAST_UPDATE_DATE, DEPRECATED, STATUS, CODE, NAME, MAINTENANCE_IND, MASTER_ID) 
SELECT code_set_id_seq.nextval, 0, 'SYSTEM', current_timestamp, 'SYSTEM', current_timestamp, 'N','ACTIVE', 'APPROVAL_EXCEPTION', 'Customer Type (Vietin Criteria) Corporate', 
'N', NULL FROM DUAL WHERE NOT EXISTS (SELECT * FROM CODE_SET WHERE CODE = 'APPROVAL_EXCEPTION' AND DEPRECATED = 'N' AND STATUS = 'ACTIVE');


INSERT INTO CODE_VALUE 
SELECT CODE_VALUE_ID_SEQ.NEXTVAL, 0, 'SYSTEM', SYSDATE, 'SYSTEM', SYSDATE, 'N', 'ACTIVE', 
'VP1', 'KH vip1', 'cus vip 1', 
(SELECT ID FROM CODE_SET WHERE CODE = 'APPROVAL_EXCEPTION' AND DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND MASTER_ID IS NULL), NULL, 1, '', '', '', '', 'N', NULL, NULL, NULL, '', NULL, 
NULL FROM DUAL WHERE NOT EXISTS (SELECT * FROM CODE_VALUE WHERE DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND CODE = 'C' AND CODE_VALUE = 'Corporate' AND CODE_SET_VALUE_ID = (SELECT ID FROM CODE_SET WHERE CODE = 'APPROVAL_EXCEPTION' AND DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND MASTER_ID IS NULL));

INSERT INTO CODE_VALUE 
SELECT CODE_VALUE_ID_SEQ.NEXTVAL, 0, 'SYSTEM', SYSDATE, 'SYSTEM', SYSDATE, 'N', 'ACTIVE', 
'VP2', 'KH vip2', 'cus vip 2', 
(SELECT ID FROM CODE_SET WHERE CODE = 'APPROVAL_EXCEPTION' AND DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND MASTER_ID IS NULL), NULL, 1, '', '', '', '', 'N', NULL, NULL, NULL, '', NULL, 
NULL FROM DUAL WHERE NOT EXISTS (SELECT * FROM CODE_VALUE WHERE DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND CODE = 'C' AND CODE_VALUE = 'Corporate' AND CODE_SET_VALUE_ID = (SELECT ID FROM CODE_SET WHERE CODE = 'APPROVAL_EXCEPTION' AND DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND MASTER_ID IS NULL));

INSERT INTO CODE_VALUE 
SELECT CODE_VALUE_ID_SEQ.NEXTVAL, 0, 'SYSTEM', SYSDATE, 'SYSTEM', SYSDATE, 'N', 'ACTIVE', 
'VP3', 'KH vip3', 'cus vip 3', 
(SELECT ID FROM CODE_SET WHERE CODE = 'APPROVAL_EXCEPTION' AND DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND MASTER_ID IS NULL), NULL, 1, '', '', '', '', 'N', NULL, NULL, NULL, '', NULL, 
NULL FROM DUAL WHERE NOT EXISTS (SELECT * FROM CODE_VALUE WHERE DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND CODE = 'C' AND CODE_VALUE = 'Corporate' AND CODE_SET_VALUE_ID = (SELECT ID FROM CODE_SET WHERE CODE = 'APPROVAL_EXCEPTION' AND DEPRECATED = 'N' AND STATUS = 'ACTIVE' AND MASTER_ID IS NULL));

COMMIT ;

select * from code_set cs where cs.code = 'APPROVAL_EXCEPTION' and cs.status = 'ACTIVE'
SELECT cv.id, cv.code, cv.code_value, cv.CODE_VALUE_EN FROM CODE_VALUE cv 
WHERE code_set_value_id IN (select cs.id from code_set cs where cs.code = 'APPROVAL_EXCEPTION' and cs.status = 'ACTIVE' ) 
                                                                 AND cv.status = 'ACTIVE' AND cv.deprecated = 'N' ;
SELECT * FROM CODE_VALUE WHERE creation_date >= trunc(sysdate) ;
SELECT * FROM CODE_SET WHERE  creation_date>= trunc(sysdate);

DELETE FROM CODE_VALUE WHERE ID IN (579598220,579598221,579598222) ; 
DELETE FROM CODE_VALUE WHERE ID IN (1213,1214,1215) ; 
COMMIT ;
                                                                 

-- 9 code 10 code_value 11 code_value_en              


ALTER TABLE SML_FACILITY DROP COLUMN APPROVAL_EXCEPTION ;

--241122
ALTER TABLE STAGE_AA_PROFILE ADD APPROVAL_EXCEPTION varchar(255); 
ALTER TABLE SCI_LSP_AA_PROFILE ADD APPROVAL_EXCEPTION varchar(255);


SELECT * FROM STAGE_AA_PROFILE WHERE APPROVAL_EXCEPTION IS NOT NULL ;
SELECT * FROM SCI_LSP_AA_PROFILE WHERE APPROVAL_EXCEPTION IS NOT NULL ;  


SELECT * FROM TRANSACTION WHERE TRANSACTION_DATE >= TRUNC(SYSDATE); --refference_id = 20221021000005926

SELECT his.transaction_date ,aa.* 
FROM STAGE_AA_PROFILE aa
JOIN (
    SELECT trans_history.staging_reference_id, trans_history.transaction_date FROM trans_history WHERE trans_history.reference_id = 20221021000005926
) his 
ON aa.cms_aa_id = his.staging_reference_id
ORDER BY his.transaction_date
; 

-- conclude: save not successfull
-- test 241122
SELECT * FROM TRANSACTION WHERE TRANSACTION_DATE >= TRUNC(SYSDATE); --refference_id = 20210929000005922

SELECT * FROM SCI_LSP_AA_PROFILE WHERE cms_aa_id = 20210929000005922 ; 
SELECT his.transaction_date ,aa.* 
FROM STAGE_AA_PROFILE aa
JOIN (
    SELECT trans_history.staging_reference_id, trans_history.transaction_date FROM trans_history WHERE trans_history.reference_id = 20210929000005922
) his 
ON aa.cms_aa_id = his.staging_reference_id
ORDER BY his.transaction_date ; 

