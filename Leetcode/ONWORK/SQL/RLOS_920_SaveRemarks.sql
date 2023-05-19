	<sql-query name="getArchivedJournalListByApplicationId" resultset-ref="archivedJournal.list">
	<![CDATA[
		SELECT 
			WF.TASK_ID,
			CASE
				WHEN WF.USER_ID IS NULL THEN '[' || RL.NAME || '] (Pools)'
				ELSE (SELECT SURNAME || ' ' || NVL(FIRST_NAME, '') AS NAME FROM LOS_USER WHERE ID = WF.USER_ID)
		      END AS ORIGINATOR, 
			CASE
		        WHEN WF.ASSG_TO_USER_ID IS NULL AND WF.TASK_STATUS != '0' THEN '[' || RLS.NAME || '] (Pools)'
		        ELSE (SELECT SURNAME || ' ' || NVL(FIRST_NAME, '') AS NAME FROM LOS_USER WHERE ID = WF.ASSG_TO_USER_ID)
		      END AS RECIPIENT,
			CASE
				WHEN WF.USER_ACTION_DSCP like '%Return%' THEN 'Return'
				ELSE TO_CHAR(WF.USER_ACTION_DSCP)
			END AS DECISION,
			CASE
				WHEN WF.USER_ACTION like '%Return%' THEN 'Returned'
				ELSE TO_CHAR(WF.APP_STATUS)
			END AS STATUS,
			WF.TASK_SEQ AS TASK_SEQ,
			WF.TASK_STATUS AS TASK_STATUS,
			WF.COMPLETE_DATE AS TRANSACTION_TIME,
			WF.USER_REMARK AS REMARKS,
			COMMON_CODE_CATEGORY_ENTRY.ENTRY_NAME AS RSN_CODE,
			--RSN.RSN_CODE,
			RSN.INTERNAL_DESCRIPTION,
			RSN.EXTERNAL_DESCRIPTION
		FROM LOS_WF_TASK_ARCHIVED WF
		INNER JOIN 
		    (
                SELECT DISTINCT TO_NUMBER(ENTRY_CODE) AS ID , ENTRY_NAME AS NAME
                FROM COMMON_CODE_CATEGORY_ENTRY 
                WHERE CATEGORY_CODE = 'LOS_ROLE_ACCESS' AND ACTIVE_STATUS = '1'
            ) RL ON WF.ROLETYPE_ID = RL.ID
		LEFT JOIN
		    (
                SELECT DISTINCT TO_NUMBER(ENTRY_CODE) AS ID , ENTRY_NAME AS NAME
                FROM COMMON_CODE_CATEGORY_ENTRY 
                WHERE CATEGORY_CODE = 'LOS_ROLE_ACCESS' AND ACTIVE_STATUS = '1'
            ) RLS ON WF.ASSG_TO_ROLE_ID = RLS.ID
		LEFT JOIN LOS_RSN RSN ON RSN.TASK_ID = WF.TASK_ID
		LEFT JOIN COMMON_CODE_CATEGORY_ENTRY ON RSN.REASON_GROUP = COMMON_CODE_CATEGORY_ENTRY.ENTRY_CODE AND COMMON_CODE_CATEGORY_ENTRY.CATEGORY_CODE = 'REASON_GROUP'
		WHERE WF.APP_ID = :application_id
		ORDER BY WF.TASK_ID
	]]>
	</sql-query>

    
    INSERT INTO CMS_FUNCTION_ACCESS values (20230518000001 ,Trim('CAAction'), Trim('save_remark'), 109);
COMMIT ;

SELECT * FROM CMS_FUNCTION_ACCESS ;

SELECT ID, REMARKS FROM LOS_CA  WHERE ID = 122523366333333;

SELECT * FROM LOS_CA WHERE APP_REF_NO = '94098PL19000167'; 

SELECT ID, REMARKS FROM LOS_CA WHERE APP_REF_NO = '94098PL19000167'; 

SELECT ID, REMARKS FROM LOS_CA WHERE ID = '20190531003164'; 

SELECT wf.USER_REMARK, wf.* FROM LOS_WF_TASK_ARCHIVED wf WHERE wf.user_remark IS NOT NULL;
SELECT ID, REMARKS FROM LOS_CA WHERE remarks IS NOT NULL ;
--20190531003164	1314223
--20190619003227	TEST 12342 21 51 923 2020 d 2e *!@#!@$12
