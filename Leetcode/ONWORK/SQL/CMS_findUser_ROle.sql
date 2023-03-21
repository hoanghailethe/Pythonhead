
SELECT * 
FROM cms_user A
JOIN CMS_TEAM_MEMBER B ON A.USER_ID = B.USER_ID 
JOIN CMS_TEAM_MEMBERSHIP C ON b.team_membership_id = c.team_membership_id
JOIN CMS_TEAM_TYPE_MEMBERSHIP D ON c.team_type_membership_id = d.team_type_membership_id
JOIN CMS_TEAM_TYPE E ON D.TEAM_TYPE_ID = E.TEAM_TYPE_ID
WHERE E.TEAM_TYPE_ID = 4
--SUCCESS: 
--CUSC106008	clims123     
--CUSC106007	2F795DEE489136705829D30375FF659C89415983
--CUSC106006	637D9BB4FF56A71F9F21E0B2D8311393DA064ED6
--CUSC106005	clims123


select table_name from all_tab_columns where column_name = 'USER_ID';  
--CMS_TEAM_MEMBER
--CMS_TEAM_MEMBERSHIP   --> TEAM_TYPE_MEMBERSHIP --> CMS_TEAM_TYPE      == 4

select table_name from all_tab_columns where column_name = 'TEAM_TYPE_ID';  --WORKED
--TRANS_HISTORY
--TRANSACTION
--CMS_TEAM
--CMS_TEAM_FUNCTION_GRP
--CMS_TEAM_TYPE
--STAGE_TEAM
--STAGE_TEAM_FUNCTION_GRP
--CMS_TEAM_TYPE_MEMBERSHIP --this

SELECT
    * FROM cms_user WHERE LOGIN_ID IN ('csamha01','cusmha01','cuscha01','CSAMHA01','CUSMHA01','CUSCHA01')
--20151021000018149
--20151021000018141
--20151021000018142


==OTHER

7.19.2020

SELECT E.TEAM_TYPE_ID , A.* 
FROM cms_user A
JOIN CMS_TEAM_MEMBER B ON A.USER_ID = B.USER_ID 
JOIN CMS_TEAM_MEMBERSHIP C ON b.team_membership_id = c.team_membership_id
JOIN CMS_TEAM_TYPE_MEMBERSHIP D ON c.team_type_membership_id = d.team_type_membership_id
JOIN CMS_TEAM_TYPE E ON D.TEAM_TYPE_ID = E.TEAM_TYPE_ID
WHERE LOGIN_ID LIKE '%CSAMHA01%'
-- ROLE 4: MAKER CHECKER: CSAM999012            --checker CUSC106007  CSA
--CUSTODIAN ROLE 1:	CUSC999012
		CUSM999012
--WHERE E.TEAM_TYPE_ID = 4    
-- 4 is custodian_checker
--SUCCESS: 
--CUSC106008	clims123
--CUSC106007	2F795DEE489136705829D30375FF659C89415983
--CUSC106006	637D9BB4FF56A71F9F21E0B2D8311393DA064ED6
--CUSC106005	clims123


SELECT
    * FROM cms_user WHERE LOGIN_ID IN ('csamha01','cusmha01','cuscha01','CSAMHA01','CUSMHA01','CUSCHA01')
--20151021000018149
--20151021000018141
--20151021000018142
    
    
SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%TEAM_TYPE_ID%'
ORDER BY    TableName
            ,ColumnName;
            
            
select * from INFORMATION_SCHEMA.COLUMNS 
where COLUMN_NAME like '%TEAM_TYPE_ID%' 
order by TABLE_NAME

select table_name from all_tab_columns where column_name = 'TEAM_TYPE_ID';  --WORKED
--TRANS_HISTORY
--TRANSACTION
--CMS_TEAM
--CMS_TEAM_FUNCTION_GRP
--CMS_TEAM_TYPE
--STAGE_TEAM
--STAGE_TEAM_FUNCTION_GRP
--CMS_TEAM_TYPE_MEMBERSHIP --this
select table_name from all_tab_columns where column_name = 'USER_ID';  
--CMS_TEAM_MEMBER
--CMS_TEAM_MEMBERSHIP   --> TEAM_TYPE_MEMBERSHIP --> CMS_TEAM_TYPE      == 4

SELECT E.TEAM_TYPE_ID , A.* 
FROM cms_user A, CMS_TEAM_TYPE E

-- PRINT PAGE-- 
select table_name from all_tab_columns where column_name LIKE '%CA_NUMBER%';
select cms_lsp_lmt_profile_id, count(*) from cms_checklist GROUP BY cms_lsp_lmt_profile_id;
select los_bca_ref_num from sci_lsp_lmt_profile where cms_lsp_lmt_profile_id = 20170220000010974;

select * from cms_document;
select * from cms_checklist;
SELECT * FROM sci_lsp_lmt_profile
SELECT cms_lsp_lmt_profile_id FROM sci_lsp_lmt_profile WHERE LOS_BCA_REF_NUM = 'CAR/13/0002/00900/0000014-002'

select cms_lsp_lmt_profile_id, count(*) from cms_cust_doc group by cms_lsp_lmt_profile_id;