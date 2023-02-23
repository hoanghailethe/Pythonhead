
ORA-00923: FROM keyword not found where expected

ORA-00923: FROM keyword not found where expected

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
--        where ARole.role_Id in (  )
	)  and A.APPROVE_AUTH in ( 'AUTO', 'BOD' , 'COB' , 'CC' ) and A.status = 'ACTIVE'
	and (((A.effective_Date_From is not null and A.effective_Date_From <= sysdate) and (A.effective_Date_To is null or A.effective_Date_To >= sysdate)) or
	(A.enable_Ind = 'N' and (A.effective_Date_From is not null and A.effective_Date_To is not null and A.effective_Date_To < sysdate) or (A.effective_Date_From is not null and A.effective_Date_From > sysdate)))
	order by A.first_name ;


	SELECT BR_CODE, us.* FROM LOS_USER us WHERE SURNAME = 'rlos23' ;
    -- ID: 20180829000171   DEPT_CODE = TSC57000      BR_CODE = 12498
    UPDATE LOS_USER SET DEPT_CODE = null, BR_CODE = 12468 WHERE ID = 20180829000171;
    COMMIT ;
    
    
    SELECT ID, SURNAME,  BR_CODE FROM LOS_USER WHERE BR_CODE LIKE '124%' ; 

	==1014
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
        AND ur.role_id = 201; 
        
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

        
        SELECT * FROM LOS_SECURITY ;
          SELECT * FROM LOS_COLLATERAL  ;
          
          
          SELECT * FROM LOS_COLL ;     -- PT20140313012944          20181205000471
       SELECT * FROM LOS_CA WHERE ID = 20181205002208  ; --20181205002208   -- APP 12498PL18000598
       
       SELECT *FROM LOS_COLL_PT ; 