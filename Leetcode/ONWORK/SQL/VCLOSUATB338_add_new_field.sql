INSERT INTO COMMON_CODE_CATEGORY (
        CATEGORY_ID,
        CATEGORY_CODE,
        CATEGORY_NAME,
        CATEGORY_TYPE,
        ACTIVE_STATUS
    )
VALUES (
        COMMON_CODE_CATEGORY_SEQ.nextval,
        'APPROVAL_EXCEPTIONAL',
        'Approval Exceptional',
        3,
        'A'
    );
insert into common_code_category_entry (
        entry_id,  -- what value ??
        entry_code,
        entry_name,
        locale_name1,
        active_status,
        country,
        category_code,
        category_code_id
    )
select common_code_category_entry_seq.nextval,
    'APPROVAL_EXCEPTIONAL',
    'Approval exceptional',
    '1',
    'A',
    'VN',
    category_code,
    category_id
from common_code_category
where category_code = 'PROP_CREDIT_LOAN_METHOD';
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
    'PENDING_CREATE',
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
--STAGE
insert into stage_common_code_entry (
        stage_id,
        entry_id,
        entry_code,
        entry_name,
        active_status,
        category_code,
        category_code_id,
        entry_source,
        country,
        group_id,
        ref_entry_code,
        staging_reference_id,
        is_new
    ) (
        select COMM_CODE_ENTRY_STG_SEQ.nextval,
            ccce.ENTRY_ID,
            ccce.entry_code,
            ccce.entry_name,
            ccce.ACTIVE_STATUS,
            ccce.CATEGORY_CODE,
            ccce.CATEGORY_CODE_ID,
            ccce.ENTRY_SOURCE,
            ccce.country,
            ccce.GROUP_ID,
            ccce.REF_ENTRY_CODE,
            ccce.CATEGORY_CODE_ID,
            'Y'
        from common_code_category_entry ccce,
            common_code_category ccc
        where ccc.category_code = ccce.CATEGORY_CODE
            and ccce.CATEGORY_CODE in ('APPROVAL_EXCEPTIONAL')
    );
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

-- TEST DATA LOCAL CLOS 1 

ALTER TABLE SML_FACILITY ADD APPROVAL_EXCEPTION varchar(255);

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

 INSERT INTO common_code_category_entry
            (entry_id,
             entry_code,
            --  ref_entry_code,
             entry_name,
             active_status,
             category_code,
             category_code_id)
(SELECT common_code_category_entry_seq.NEXTVAL,
        'Ex2', -- ??
        -- 'MS601', --?? 
        'VIP CUS 2', --?
        '1', --?
        category_code,
        category_id
 FROM   common_code_category
 WHERE  category_code = 'APPROVAL_EXCEPTIONAL');

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
