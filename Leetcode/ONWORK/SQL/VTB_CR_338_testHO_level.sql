-- TEST VAIRAITOPM STP AP 

-- CMS
SELECT * FROM SCI_LSP_AA_PROFILE WHERE los_bca_ref_num = 'CAR/23/0001/00122/00009328'; 

UPDATE SCI_LSP_AA_PROFILE SET approval_exception = 'LM100' WHERE los_bca_ref_num = 'CAR/23/0001/00122/00009328'; 
COMMIT ;


--NOTE
PT20130826007376

	Normal  
Application Number ^	CAR/16/0001/00122/00008139 


Type of CAR *	Credit Card  
Application Number ^	CAR/23/0001/00122/00009328 


SELECT * FROM SML_USER WHERE LOGIN_ID IN ('rmklinh001', 'caklinh001');
--201509210000009675
--201509210000009672
--201509210000009673
--201509210000009666

-- CLOS
SELECT * FROM SML_CA WHERE ca_number = 'CAR/23/0001/00122/00009328' ;
201510140000005341	20130524000001	Template Product Package	01-MAR-23		rmklinh001	201509210000009666					CAR/23/0001/00122/00009328
PREPARER_ID : 201509210000009666

01-MAR-23	201510140000005341	20130524000001	Template Product Package	01-MAR-23		rmklinh001	201509210000009666					CAR/23/0001/00122/00009328		206							PENDING_APPROVAL		N	N
PREPARER


 public ITeam getTeamSpecificDetailsByUserId(Long userOrMasterId) {
    	List<SqlParameter> searchParamTypeList = new ArrayList<SqlParameter>();
        List<Object> searchParamValueList = new ArrayList<Object>();

        String sql = "";
        	sql = " select team.id, team.role_id, team.level_id, region_id, area_id, branch_id from sml_team team " +
        			" inner join sml_team_member mem on mem.team_id = team.id and team.status = 'ACTIVE' and team.master_id is null " +
        			" where mem.user_id = ? ";
        	searchParamTypeList.add(new SqlParameter(Types.BIGINT));
            searchParamValueList.add(userOrMasterId);
        DefaultLogger.debug(this, "\n\n========== getTeamSpecificDetailsByUserId =========\n" + sql + "\n\n");

VAR CAR :
AR Reference Number	CAR/23/0001/00122/00009328 
Application Number ^	CAR/23/0001/00122/00009329 

== NEXT STEP FIND an HO LEVER to ESCALATE -- sql to find HO LEVEL member

select team.id, team.role_id, team.level_id, region_id, area_id, branch_id from sml_team team 
inner join sml_team_member mem on mem.team_id = team.id and team.status = 'ACTIVE' and team.master_id is null 
 where mem.user_id = ;

SELECT * FROM SML_USER WHERE LOGIN_ID = 'rmklinh001' ;

SELECT team.level_id, region_id, area_id, branch_id from sml_team team 
inner join sml_team_member mem on mem.team_id = team.id and team.status = 'ACTIVE' and team.master_id is null 
where mem.user_id = 201509210000009666;


 <sql-query name="HQL.findCodeValueByCodeSetCodeAndCodeValueCode(codeSetCode,codeValueCode)" resultset-ref="code.value.object">
	<![CDATA[SELECT VAL.*
			  FROM CODE_SET CODESET
			       INNER JOIN
			          CODE_VALUE VAL
			       ON CODESET.id = VAL.CODE_SET_VALUE_ID
			 WHERE  CODESET.CODE = :setCode 
			        AND VAL.CODE = :valueCode 
			        AND VAL.DEPRECATED = 'N'
			        AND CODESET.STATUS = 'ACTIVE'
			        AND CODESET.MASTER_ID IS NULL]]>
	</sql-query>

    ICodeValue teamLevelCv = UIUtil.deriveCodeValueObjById(CodeSetConstants.TEAM_LEVEL, String.valueOf(rs.getLong("level_id")));
        TEAM_LEVEL  


--LEVEL_ID : 131

SELECT * FROM CODE_SET WHERE CODE ='TEAM_LEVEL';

SELECT * FROM CODE_VALUE ;

SELECT VAL.*
  FROM CODE_SET CODESET
       INNER JOIN
          CODE_VALUE VAL
       ON CODESET.id = VAL.CODE_SET_VALUE_ID
 WHERE  CODESET.CODE = 'TEAM_LEVEL';
--        AND VAL.CODE LIKE '%131%'
--        AND VAL.DEPRECATED = 'N'
--        AND CODESET.STATUS = 'ACTIVE'
--        AND CODESET.MASTER_ID IS NULL ;

SELECT * FROM CODE_SET WHERE ID IN (200,5) AND CODE = 'TEAM_LEVEL'; -- HO

-- FIND a HO MEM
SELECT * from sml_team team 
inner join sml_team_member mem on mem.team_id = team.id and team.status = 'ACTIVE' and team.master_id is null 
where team.level_id IN( 1365, 126);

-- ALL HERE IS HO
SELECT u.* from  sml_team team 
inner join sml_team_member mem on mem.team_id = team.id 
JOIN SML_USER u ON mem.user_id = u.id
and team.status = 'ACTIVE' and team.master_id is null 
where team.level_id IN( 1365, 126);
-- 20130525000758	40	scmaker7	25-MAY-13	scchecker7	14-JUN-19	N	N	ACTIVE	HO010	HO010 CA
-- 20130525000775	26	manh.sc	25-MAY-13	manh.scc	14-JUN-19	N	N	ACTIVE	HO027	HO027	TF999098 TEAM LEAD HM

201511130000009858  rmtlklinh008
201509220000009733  rmtlklinh004


-- TEST ASCALATING
Customer: SMOKE 30062016
CAR: CAR/17/0001/00122/00008863 ( Pending Approval )
-> rmtlklinh008

LOGIN rmtlklinh008
