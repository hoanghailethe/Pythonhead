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
 WHERE  CODESET.CODE = 'TEAM_LEVEL' and CODESET.id in (200,5);
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


SELECT * FROM SML_CA WHERE CA_NUMBER = 'CAR/17/0001/00122/00008863';
SELECT * FROM SML_CA_AM WHERE CA_ID =  201707130000023253 ;
--approvaerID ;201509210000009672
SELECT * FROM SML_USER WHERE ID = 201509210000009672 ;


-- TODO of peson is escalated
 FROM 
      sml_fp_folder ff 
      inner join sml_fp_folder_details det ON det.fp_folder_id = ff.id 
      inner join SML_TRX trx on trx.stage_ref_id = ff.id 
      inner join SML_TRX_TYPE trx_type on trx.trx_type_id = trx_type.id 
      inner join SML_TRX_EXT_INFO trx_ext_info on trx_type.id = trx_ext_info.trx_type_id 
      AND trx.state = trx_ext_info.state 
      inner join SML_USER usr_org on usr_org.id = trx.originator_id 
    WHERE 
      trx.state <> 'ARCHIVED' 
      AND Nvl(trx.in_process_ind, 'N') != 'Y' 
      AND (
        trx.state = 'PENDING_REVIEW' 
        AND (trx.next_owner_id = ?) 
        AND trx.trx_type_id IN (
          select 
            distinct accessFunction.trx_type_id 
          from 
            sml_team team 
            inner join sml_team_member teamMember on teamMember.team_id = team.id 
            and team.status = 'ACTIVE' 
            and teamMember.user_id = ? 
            inner join sml_user_access_function userAccessFunc on userAccessFunc.profile_id = teamMember.profile_id 
            inner join sml_access_function accessFunction on accessFunction.id = userAccessFunc.access_function_id 
          where 
            accessFunction.trx_type_id is not null 
            and accessFunction.name LIKE '%rmtl:todo-draft%'
        )


(
            select 
              full_name 
            from 
              sml_user 
            where 
              id = trx.next_owner_id
          ) as next_owner_name, trx.next_owner_id,
FROM 
      sml_fp_folder ff 
      inner join sml_fp_folder_details det ON det.fp_folder_id = ff.id 
      inner join SML_TRX trx on trx.stage_ref_id = ff.id 
      inner join SML_TRX_TYPE trx_type on trx.trx_type_id = trx_type.id 
      inner join SML_TRX_EXT_INFO trx_ext_info on trx_type.id = trx_ext_info.trx_type_id 
      AND trx.state = trx_ext_info.state 
      inner join SML_USER usr_org on usr_org.id = trx.originator_id 

	  sml_ca fp 
          INNER JOIN sml_prod_package pp ON fp.prod_package_id = pp.id 
          INNER JOIN sml_customer c ON fp.borrower_id = c.id 
          INNER JOIN sml_fp_folder_details fd ON fd.fp_id = fp.id 
          LEFT JOIN sml_ooe_group_member mem ON mem.customer_id = c.id 
          LEFT JOIN sml_ooe_group ooe ON ooe.id = mem.ooe_group_id 
          INNER JOIN sml_trx trx ON trx.stage_ref_id = fd.fp_folder_id 
          AND ? IN (
            trx.originator_id, trx.next_owner_id
          ) ;

SELECT TRX.* FROM sml_ca fp 
          INNER JOIN sml_fp_folder_details fd ON fd.fp_id = fp.id 
          INNER JOIN sml_trx trx ON trx.stage_ref_id = fd.fp_folder_id 
		  WHERE fp.CA_NUMBER = 'CAR/17/0001/00122/00008863';
201511130000009858  next_owner_id

SELECT * FROM SML_USER WHERE ID = 201511130000009858 ; --rmtlklinh008

TEST THEM CAR 
Customer: TRANG I2109
CAR: CAR/19/0001/00122/00009172 ( Pending Approval )
 Score
