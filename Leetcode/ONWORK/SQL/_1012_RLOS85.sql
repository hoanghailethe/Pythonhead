
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