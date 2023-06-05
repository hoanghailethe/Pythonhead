INSERT INTO MIG_QC_REPORT (RECORD_TYPE, TEXT, SYSTEM_ID, INTERFACE_ID)
	(SELECT 'IsValid', CHAR(COUNT(*)), 'SIBS', 'CA004' FROM SI_TEMP_SIBS_CA004 WHERE IS_VALID = 'Y');


    SI_TEMP_SIBS_CA004
    CREATE OR REPLACE PROCEDURE BULK_INSERT_CA004 (p_array_

    SI_TEMP_SIBS_CA023

    CREATE OR REPLACE PROCEDURE SI_RUN_SIBS_CA023
AS

CREATE OR REPLACE PROCEDURE SI_RUN_SIBS_CA023
AS


BULK_INSERT_CA023_DAILY(v_per_loop);


-- 010623 - proc dong bo cms core

 insert into common_code_category_entry (entry_id, entry_code, entry_name, locale_name1, ref_entry_code, active_status, country, category_code, category_code_id)
    select (CAST(TS_FMT(sysdate, 'yyyymmdd') || lpad(common_code_category_entry_seq.nextval,9,'0') as NUMBER(19,0))),
    user_id, branch_no, branch_no, bank_no, '1', 'VN', 'APPROVAL_CODE', v_category_id
    FROM HP_TEMP_PF218 WHERE RECORD_TYPE NOT IN ('H','T')
    and (user_id, branch_no, bank_no) not in
        (select entry_code, entry_name, ref_entry_code from common_code_category_entry where category_code = 'APPROVAL_CODE');

commit;

 MERGE INTO common_code_category_entry b
        USING (
        select USER_ID, BRANCH_NO, BANK_NO
        FROM HP_TEMP_PF218) e
        ON (b.entry_code = e.user_id and b.entry_name = e.branch_no and b.ref_entry_code = e.bank_no and b.category_code = 'APPROVAL_CODE')
        WHEN MATCHED THEN
        UPDATE SET b.active_status = '1' where b.active_status = '0';


CREATE OR REPLACE PROCEDURE SI_RUN_TEMP_APPROVAL_CODE



SELECT * FROM common_code_category_entry WHERE ENTRY_CODE LIKE '%27A%' ; 

SELECT * FROM common_code_category_entry WHERE CATEGORY_CODE LIKE '%27A%' ; 

SELECT 
       table_name
from sys.all_tables
where table_name like 'INTERFACE%'  ; --   INTERFACE_BATCH_MAPPING 

SELECT * FROM HP_TEMP_PF218 ; 

CREATE PROCEDURE si_auto_feed_standard_code
		(p_entry_code VARCHAR(40), p_entry_name VARCHAR(255), p_category_code VARCHAR(40), p_entry_source VARCHAR(40))
	LANGUAGE SQL
BEGIN ATOMIC
	DECLARE v_count INT;
	DECLARE v_category_code_id BIGINT;
	
	SELECT COUNT(1) INTO v_count
	  FROM common_code_category_entry
	 WHERE category_code = p_category_code
	   AND entry_code = p_entry_code
	   AND entry_source = p_entry_source;
	   
	IF (v_count > 0) THEN 
		UPDATE common_code_category_entry
		   SET entry_name = p_entry_name
		 WHERE category_code = p_category_code
	   	   AND entry_code = p_entry_code
	   	   AND entry_source = p_entry_source;
	ELSE
		-- MUST make sure Category Code exists
		SELECT category_id
		  INTO v_category_code_id
		  FROM common_code_category
		 WHERE category_code = p_category_code
		 FETCH FIRST 1 ROW ONLY;

		INSERT INTO common_code_category_entry (entry_id, entry_code, entry_name, active_status, category_code, 
												category_code_id, entry_source, country)
		VALUES ((NEXT VALUE FOR COMMON_CODE_CATEGORY_ENTRY_SEQ), p_entry_code, p_entry_name, '1', p_category_code,
				v_category_code_id, p_entry_source, 'MY');
	END IF;

    D:\VTBCLIMS\scripts\db_merging\system-interface\cms_system_interface_utility.sql
	
END@


SI_RUN_TEMP_SIBS_CU001
SI_TEMP_SIBS_CU001

SI_RUN_TEMP_SIBS_CU001

si_temp_SIBS_co010
SI_RUN_TEMP_SIBS_CO010

MIG_CO013
MIG_RUN_CO013


SELECT * FROM common_code_category_entry WHERE CATEGORY_CODE LIKE '%27A%' ORDER BY ENTRY_CODE DESC; 

SELECT * FROM CODE_VALUE WHERE CATEGORY_CODE LIKE '%27A%' ORDER BY ENTRY_CODE DESC; 


-- CLOS CHECK SQL
  MERGE INTO   code_value
        USING   (SELECT
                          'SYSTEM' AS create_by,
                          CURRENT_TIMESTAMP AS creation_date,
                          'SYSTEM' AS last_update_by,
                          CURRENT_TIMESTAMP AS last_update_date,
                          decode (ce.active_status , '0' ,'Y' , 'N')   AS deprecated,
                          decode (ce.active_status , '0' ,'DELETED' , 'ACTIVE')    AS status,
                          entry_name AS code_value,
                          LOCALE_NAME1 as CODE_VALUE_EN,                          
                          entry_source AS entry_source,
                          country,
                          --VCLOSSITA-282 :COMMON_CODE_CATEGORY_ENTRY.REF_ENTRY_CODE map to code_value.display_order
                          ref_entry_code AS display_order,
                          'CMS' AS source,
                          cs.id AS cs_id,
                          --VCLOSSITA-282 : COMMON_CODE_CATEGORY_ENTRY.REF_ENTRY_CODE  NOT map to code_value.code_value_parent_code
                          --ref_entry_code,
                          entry_code AS code
                   FROM   common_code_category_entry ce, code_set cs
                   WHERE   ce.category_code = cs.code
                   AND ce.category_code IN ('AA_TREASURY_TENOR','AA_PRODUCT_GROUP','AA_ISSUER_LIMIT_TENOR'))
                ce_update
           ON   (code_value.code = ce_update.code
                 AND code_value.code_set_value_id = ce_update.cs_id
                )

--CMS 
SELECT * FROM common_code_category_entry WHERE CATEGORY_CODE LIKE '%27A%' ORDER BY ENTRY_CODE DESC; 

SELECT * FROM CODE_VALUE WHERE CATEGORY_CODE LIKE '%27A%' ORDER BY ENTRY_CODE DESC; 

-- CLOS -- 
SELECT * FROM code_set WHERE CODE = '27A' ;
SELECT * FROM code_set cs JOIN common_code_category_entry ce ON cs.CODE = ce.CATEGORY_CODE
WHERE CODE = '27A' ORDER BY ENTRY_CODE DESC;
SELECT * FROM CODE_VALUE WHERE
    code IN (SELECT ENTRY_CODE FROM common_code_category_entry WHERE CATEGORY_CODE = '27A') ORDER BY CODE DESC;