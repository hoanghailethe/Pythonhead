SELECT CE.ENTRY_ID, CE.ENTRY_CODE, CE.ENTRY_NAME, CE.ENTRY_NAME_2, CE.CATEGORY_CODE, CE.CATEGORY_CODE_ID, 
			    CE.ENTRY_SOURCE, CE.REF_ENTRY_CODE, CE.ACTIVE_STATUS, 'ACTIVE' AS USER_STATUS
			FROM COMMON_CODE_CATEGORY_ENTRY CE
			WHERE CATEGORY_CODE_ID = 203
			AND CATEGORY_CODE_ID NOT IN (
			    SELECT DISTINCT TRX.REFERENCE_ID
			    FROM LOS_TRX_ADMIN TRX
			    INNER JOIN COMMON_CODE_ENTRY_STG CES ON CES.CATEGORY_CODE_ID = TRX.STAGING_REF_ID
			    WHERE TRX.TRANSACTION_TYPE = 'COMMON_CODE'
			    AND TRX.REFERENCE_ID = 203
                AND (TRX.STATUS LIKE 'PENDING%' OR TRX.STATUS LIKE 'REJECTED%')
			)
			
			UNION
			
			SELECT CES.ENTRY_ID, CES.ENTRY_CODE, CES.ENTRY_NAME, CES.ENTRY_NAME_2, CES.CATEGORY_CODE, CES.CATEGORY_CODE_ID, 
			    CES.ENTRY_SOURCE, CES.REF_ENTRY_CODE, CES.ACTIVE_STATUS, UPPER(TO_CHAR(TRX.USER_STATUS)) AS USER_STATUS
			FROM LOS_TRX_ADMIN TRX
			INNER JOIN COMMON_CODE_ENTRY_STG CES ON CES.CATEGORY_CODE_ID = TRX.STAGING_REF_ID
			WHERE TRX.TRANSACTION_TYPE = 'COMMON_CODE'
			AND TRX.REFERENCE_ID = 203
            AND (TRX.STATUS LIKE 'PENDING%' OR TRX.STATUS LIKE 'REJECTED%');
            
            
            SELECT * FROM COMMON_CODE_CATEGORY WHERE CATEGORY_NAME LIKE '%Approve Authority%';

SELECT * FROM COMMON_CODE_CATEGORY_ENTRY WHERE CATEGORY_CODE = 'APPROVE_AUTH' 
--AND ENTRY_CODE = :entryCode 
AND ACTIVE_STATUS = 1;

UPDATE LOS_USER SET ENABLE_IND ='Y' WHERE LOGIN_NAME = 'TRANG01';
COMMIT;

UPDATE COMMON_CODE_CATEGORY_ENTRY SET REF_ENTRY_CODE = '2030' WHERE entry_code = 'BOD';
COMMIT;

SELECT * FROM LOS_CA ;

SELECT * FROM LOS_USER WHERE ID = 20180824000123;

SELECT * FROM LOS_RULE_APPROVAL_DOA ;

AUTO BOD CADx COB CC

SELECT * FROM LOS_USER A

SELECT user.* 
FROM LOS_USER user where user.id in (
		select userRole.user_Id from LOS_USER_ROLE  userRole 
--        where userRole.role_Id in ( )
	)  and user.APPROVE_AUTH in ( 'AUTO', 'BOD' , 'COB' , 'CC' ) and user.status = 'ACTIVE'
	and (((user.effective_Date_From is not null and user.effective_Date_From <= sysdate) and (user.effective_Date_To is null or user.effective_Date_To >= sysdate)) or
	(user.enable_Ind = 'N' and (user.effective_Date_From is not null and user.effective_Date_To is not null and user.effective_Date_To < sysdate) or (user.effective_Date_From is not null and user.effective_Date_From > sysdate)))
	order by user.first_name ;
    
 
 
    
    SELECT A.* 
FROM LOS_USER A where A.id in (
		select ARole.USER_Id from LOS_USER_ROLE  ARole 
        where ARole.role_Id in (  200,201,202 )
	)  and A.APPROVE_AUTH in ( 'AUTO', 'BOD' , 'COB' , 'CC' ) and A.status = 'ACTIVE'
	and (((A.effective_Date_From is not null and A.effective_Date_From <= sysdate) and (A.effective_Date_To is null or A.effective_Date_To >= sysdate)) or
	(A.enable_Ind = 'N' and (A.effective_Date_From is not null and A.effective_Date_To is not null and A.effective_Date_To < sysdate) or (A.effective_Date_From is not null and A.effective_Date_From > sysdate)))
	order by A.first_name ;
    
    
        
    SELECT A.* 
FROM LOS_USER A where A.id in (
		select ARole.USER_Id from LOS_USER_ROLE  ARole 
        where ARole.role_Id in (  200,201,202 )
	)  and A.APPROVE_AUTH in ('CAD') and A.status = 'ACTIVE'
	and (((A.effective_Date_From is not null and A.effective_Date_From <= sysdate) and (A.effective_Date_To is null or A.effective_Date_To >= sysdate)) or
	(A.enable_Ind = 'N' and (A.effective_Date_From is not null and A.effective_Date_To is not null and A.effective_Date_To < sysdate) or (A.effective_Date_From is not null and A.effective_Date_From > sysdate)))
	order by A.first_name ;
    
    
    update los_user set enable_ind = 'Y';
    COMMIT;
    
    
    
    SELECT BR_CODE, BOOK_BR_CODE, LOS_CA.* FROM LOS_CA WHERE BR_CODE != BOOK_BR_CODE;
    
    
    
    
    SELECT BR_CODE, us.* FROM LOS_USER us WHERE SURNAME = 'rlos23' ;
    -- ID: 20180829000171   DEPT_CODE = TSC57000      BR_CODE = 12498
    UPDATE LOS_USER SET DEPT_CODE = null, BR_CODE = 12468 WHERE ID = 20180829000171;
    COMMIT ;
    
    
    SELECT ID, SURNAME,  BR_CODE FROM LOS_USER WHERE BR_CODE LIKE '124%' ; 
    
    
    SELECT ID, CREATE_BY, HOLDER_1, ca.* FROM LOS_CA ca WHERE HOLDER_1 != CREATE_BY; 
    
        SELECT ca.ID, ca.CREATE_BY, ca.HOLDER_1,ur.role_id, ca.* 
        FROM LOS_CA ca, LOS_USER us, LOS_USER_ROLE ur
        WHERE us.id = ca.create_by
        AND us.id = ur.user_id
--        AND ca.HOLDER_1 = ca.CREATE_BY
--        AND ur.role_id = 201; 

SELECT DISTINCT(ur.role_id) 
        FROM LOS_CA ca, LOS_USER us, LOS_USER_ROLE ur
        WHERE us.id = ca.create_by
        AND us.id = ur.user_id
        
        SELECT * FROM LOS_RULE_APPROVAL_DOA WHERE CA_ID = 20180921000710; 
        
        --id user who create : 20180824000122
        SELECT * FROM LOS_USER_ROLE WHERE USER_ID = 20180910000257 ;
20181218002201	101	20180910000257	ACTIVE
20181218002202	100	20180910000257	ACTIVE
20181218002203	19	20180910000257	ACTIVE
20181218002204	25	20180910000257	ACTIVE
        UPDATE LOS_USER_ROLE SET ROLE_ID = 200 WHERE ID = 20181218002201 ;
        COMMIT ;
        
--        						obRuleApprovalDOA = ruleManager.findRuleApprovalDOA(20180921000710l);

SELECT ur.role_id, us.*
        FROM LOS_USER us, LOS_USER_ROLE ur
        WHERE us.id = ur.user_id AND ur.role_id =100;
        
        UPDATE COMMON_CODE_CATEGORY_ENTRY SET ref_entry_code = '200.201' WHERE ENTRY_CODE = 'CAD' AND category_code = 'APPROVE_AUTH';
        COMMIT;
        SELECT * FROM COMMON_CODE_CATEGORY_ENTRY WHERE ENTRY_CODE = 'CAD' ;   
        ROLLBACK; 

        
        