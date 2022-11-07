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
             ref_entry_code,
             entry_name,
             active_status,
             category_code,
             category_code_id)
(SELECT common_code_category_entry_seq.NEXTVAL,
        'C99', -- ??
        'MS601', --?? 
        'STOCKS \& SHARES ETC', --?
        '1', --?
        category_code,
        category_id
 FROM   common_code_category
 WHERE  category_code = 'APPROVAL_EXCEPTIONAL');