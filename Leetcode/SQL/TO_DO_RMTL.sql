SELECT 
  COUNT(*) 
FROM 
  (
    SELECT 
      distinct null USER_STATE, 
      0 ORIGINATOR_ID, 
      ff.id FP_ID, 
      ff.CREATION_DATE FP_CREATION_DATE, 
      ff.LAST_UPDATE_DATE FP_LAST_UPDATE_DATE, 
      0 TOTAL_AMT, 
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
        trx.state IN (
          'DECLINED', 'RETURNED', 'APPROVED', 
          'LO_GEN', 'PEND_LO_GEN'
        ) 
        AND (
          trx.originator_id = ? 
          OR trx.next_owner_id = ?
        ) 
        AND trx.trx_type_id in (
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
            and accessFunction.name LIKE '%:create-fp%'
        ) 
        AND trx.stage_ref_id = ff.id 
        AND trx.trx_type_id = trx_type.id 
        AND trx_type.id = trx_ext_info.trx_type_id 
        AND trx.state = trx_ext_info.state 
        AND usr_org.id = trx.originator_id
      ) 
    UNION 
      (
        SELECT 
          distinct null user_state, 
          usr_org.id originator_id, 
          c.customer_name AS customer_name, 
          to_nchar(fp.ca_number) || ' - ' || fp.description AS fp_desc, 
          fp.id as fp_id, 
          fp.creation_date as fp_creation_date, 
          fp.last_update_date as fp_last_update_date, 
          (
            SELECT 
              code_value 
            FROM 
              code_value 
            WHERE 
              id = fp.application_req_type
          ) || (
            case when (fp.pending_valuation_ind = 'Y') then to_nchar(
              '(Pending Formal Valuation Update)'
            ) else to_nchar('') end
          ) AS app_type, 
          (
            SELECT 
              Min(trail.last_update_date) 
            FROM 
              SML_FP_TRAILS trail 
            WHERE 
              trail.ca_id = fp.id 
              and state = 'PENDING_REVIEW'
          ) as date_first_submitted, 
          (
            case pp.type when 'P' then pp.name else (
              select 
                cpp.name 
              from 
                sml_prod_package cpp 
              where 
                pp.package_id = cpp.id
            ) end
          ) as pp_name, 
          (
            case pp.type when 'C' then pp.name else to_nchar('-') end
          ) as campaign_name, 
          fp.id stage_ref_id, 
          trx_type.trx_group as trx_group_name, 
          info.event as trx_event, 
          trx.next_owner_id as next_owner_id, 
          trx.last_owner_id, 
          (
            select 
              full_name 
            from 
              sml_user 
            where 
              id = trx.last_owner_id
          ) as last_owner_name, 
          (
            select 
              full_name 
            from 
              sml_user 
            where 
              id = trx.next_owner_id
          ) as next_owner_name, 
          to_nchar('Submission of Routing Folder') as user_trx_desc, 
          to_nchar('Submission of Routing Folder') as user_trx_parameter, 
          trx.last_update_date as user_trx_date, 
          usr_org.full_name as orignator_name, 
          fp.status as user_trx_status, 
          fp.pending_valuation_ind, 
          (
            SELECT 
              code_value 
            from 
              code_value va 
            where 
              va.ID = to_number(fp.car_type)
          ) as car_type, 
          (
            SELECT 
              Sum(
                convert_amt(
                  fa.PROPOSED_LIMIT, fa.PROPOSED_LIMIT_CCY, 
                  'VND'
                )
              ) total_amt 
            FROM 
              sml_facility fa 
            WHERE 
              fa.ca_id = fp.id
          ) total_amt, 
          fp.INTEGRATION_STS_1 as stp_status, 
          (
            SELECT 
              Max(trail.last_update_date) 
            FROM 
              SML_FP_TRAILS trail 
            WHERE 
              trail.ca_id = fp.id 
              and state not in ('ABORTED', 'DRAFT') 
              and last_state is not null
          ) as date_last_submitted, 
          NULL AS lo_expiry_date 
        FROM 
          sml_ca fp 
          inner join sml_prod_package pp on fp.prod_package_id = pp.id 
          inner join SML_USER usr_org on usr_org.login_id = fp.create_by 
          AND usr_org.master_id IS NULL 
          inner join sml_customer c on fp.borrower_id = c.id 
          inner join sml_fp_folder_details ff ON ff.fp_id = fp.id 
          inner join sml_trx trx ON trx.stage_ref_id = ff.fp_folder_id 
          inner join sml_trx_type trx_type on trx_type.trx_group = 'APPROVAL_FOLDER_TRX' 
          AND trx_type.id = trx.trx_type_id 
          inner join sml_trx_ext_info info on trx_type.id = info.trx_type_id 
          AND fp.status = info.state 
          AND fp.status IN (
            'APPROVED', 'RETURNED', 'DECLINED', 
            'LO_GEN', 'PEND_LO_GEN', 'PEND_LO_ACCEPT'
          ) 
          AND (
            fp.deprecated IS NULL 
            OR fp.deprecated = 'N'
          ) 
        where 
          fp.preparer_id = ?
      ) 
    UNION 
      (
        SELECT 
          DISTINCT NULL user_state, 
          NULL refer_count, 
          usr_org.id originator_id, 
          NULL ooe_grp_name, 
          c.customer_name AS customer_name, 
          TO_NCHAR(fp.ca_number) || ' - ' || fp.description AS fp_desc, 
          fp.id as fp_id, 
          fp.creation_date as fp_creation_date, 
          fp.last_update_date as fp_last_update_date, 
          (
            SELECT 
              code_value 
            FROM 
              code_value 
            WHERE 
              id = fp.application_req_type
          ) AS app_type, 
          (
            SELECT 
              Min(trail.last_update_date) 
            FROM 
              SML_FP_TRAILS trail 
            WHERE 
              trail.ca_id = fp.id 
              and state = 'PENDING_REVIEW'
          ) as date_first_submitted, 
          (
            case pp.type when 'P' then pp.name else (
              select 
                cpp.name 
              from 
                sml_prod_package cpp 
              where 
                pp.package_id = cpp.id
            ) end
          ) as pp_name, 
          (
            case pp.type when 'C' then pp.name else to_nchar('-') end
          ) as campaign_name, 
          NULL as id, 
          fp.id stage_ref_id, 
          trx_type.trx_group as trx_group_name, 
          NULL as last_remarks, 
          info.event as trx_event, 
          trx.next_owner_id as next_owner_id, 
          trx.last_owner_id, 
          (
            select 
              full_name 
            from 
              sml_user 
            where 
              id = trx.last_owner_id
          ) as last_owner_name, 
          (
            select 
              full_name 
            from 
              sml_user 
            where 
              id = trx.next_owner_id
          ) as next_owner_name, 
          to_nchar('Submission of Routing Folder') as user_trx_desc, 
          to_nchar('Submission of Routing Folder') as user_trx_parameter, 
          trx.last_update_date as user_trx_date, 
          usr_org.full_name as orignator_name, 
          fp.status as user_trx_status, 
          fp.pending_valuation_ind, 
          (
            SELECT 
              code_value 
            from 
              code_value va 
            where 
              va.ID = to_number(fp.car_type)
          ) as car_type, 
          0 total_amt, 
          fp.INTEGRATION_STS_1 as stp_status, 
          (
            SELECT 
              Max(trail.last_update_date) 
            FROM 
              SML_FP_TRAILS trail 
            WHERE 
              trail.ca_id = fp.id 
              and state not in ('ABORTED', 'DRAFT') 
              and last_state is not null
          ) as date_last_submitted, 
          NULL AS lo_expiry_date 
        FROM 
          sml_ca fp 
          INNER JOIN sml_prod_package pp on fp.prod_package_id = pp.id 
          INNER JOIN SML_USER usr_org on usr_org.login_id = fp.create_by 
          AND usr_org.master_id IS NULL 
          INNER JOIN sml_customer c on fp.borrower_id = c.id 
          INNER JOIN sml_fp_folder_details ff ON ff.fp_id = fp.id 
          INNER JOIN sml_trx trx ON trx.stage_ref_id = ff.fp_folder_id 
          INNER JOIN sml_trx_type trx_type on trx_type.trx_group = 'RATING_TRX' 
          AND trx_type.id = trx.trx_type_id 
          INNER JOIN sml_trx_ext_info info on trx_type.id = info.trx_type_id 
          AND fp.status = info.state 
          AND fp.status IN ('RETURNED') 
          AND (
            fp.deprecated IS NULL 
            OR fp.deprecated = 'N'
          ) 
        WHERE 
          fp.preparer_id = ?
      ) 
    UNION 
      (
        SELECT 
          distinct trx.user_state, 
          null refer_count, 
          trx.originator_id, 
          ooe.group_name ooe_grp_name, 
          c.customer_name, 
          to_nchar(fp.ca_number) || ' - ' || fp.description AS fp_desc, 
          fp.id fp_id, 
          fp.creation_date fp_creation_date, 
          fp.last_update_date fp_last_update_date, 
          trx.user_trx_type || '(Credit Memo)' app_type, 
          trx.creation_date date_first_submitted, 
          (
            case pp.type when 'P' then pp.name else (
              select 
                cpp.name 
              from 
                sml_prod_package cpp 
              where 
                pp.package_id = cpp.id
            ) end
          ) as pp_name, 
          (
            case pp.type when 'C' then pp.name else to_nchar('-') end
          ) as campaign_name, 
          trx.id, 
          trx.stage_ref_id, 
          trx_type.trx_group as trx_group_name, 
          trx.remarks as last_remarks, 
          info.event as trx_event, 
          trx.next_owner_id, 
          trx.last_owner_id, 
          (
            select 
              full_name 
            from 
              sml_user 
            where 
              id = trx.last_owner_id
          ) as last_owner_name, 
          (
            select 
              full_name 
            from 
              sml_user 
            where 
              id = trx.next_owner_id
          ) as next_owner_name, 
          trx_type.description user_trx_desc, 
          trx.user_trx_type as user_trx_parameter, 
          trx.last_update_date user_trx_date, 
          uo.full_name orignator_name, 
          trx.state user_trx_status, 
          fp.pending_valuation_ind, 
          (
            SELECT 
              code_value 
            from 
              code_value va 
            where 
              va.ID = to_number(fp.car_type)
          ) as car_type, 
          (
            SELECT 
              Sum(
                convert_amt(
                  fa.PROPOSED_LIMIT, fa.PROPOSED_LIMIT_CCY, 
                  'VND'
                )
              ) total_amt 
            FROM 
              sml_facility fa 
            WHERE 
              fa.ca_id = fp.id
          ) total_amt, 
          fp.INTEGRATION_STS_1 as stp_status, 
          (
            SELECT 
              Max(trail.last_update_date) 
            FROM 
              SML_FP_TRAILS trail 
            WHERE 
              trail.ca_id = fp.id 
              and state not in ('ABORTED', 'DRAFT') 
              and last_state is not null
          ) as date_last_submitted, 
          NULL AS lo_expiry_date 
        FROM 
          sml_ca fp 
          inner join sml_customer c ON fp.borrower_id = c.id 
          LEFT join sml_ooe_group_member mem ON mem.customer_id = c.id 
          LEFT join sml_ooe_group ooe ON ooe.id = mem.ooe_group_id 
          inner join sml_credit_memo cm ON cm.ca_id = fp.id 
          inner join sml_prod_package pp ON fp.prod_package_id = pp.id 
          inner join sml_fp_folder_details fd ON fd.credit_memo_id = cm.id 
          inner join sml_trx trx ON trx.stage_ref_id = fd.fp_folder_id 
          AND ? IN (
            trx.originator_id, trx.next_owner_id
          ) 
          AND trx.state IN (
            'DECLINED', 'RETURNED', 'APPROVED', 
            'LO_GEN', 'PEND_LO_GEN', 'LO_ACCEPT', 
            'LO_REJECT', 'LO_NOT_REQ'
          ) 
          inner join sml_trx_type trx_type ON trx_type.id = trx.trx_type_id 
          AND trx_type.trx_group = 'CREDIT_MEMO_TRX' 
          inner join sml_trx_ext_info info ON info.trx_type_id = trx_type.id 
          AND info.state = trx.state 
          inner join sml_user uo ON uo.id = trx.originator_id 
        WHERE 
          fp.PREPARER_ID = ?
      )
  ) temp


  SELECT * FROM SML_CA WHERE PREPARER_ID = ?????
		INNER JOIN SML_USER ON USER_ID = PREPARER_ID


SELECT PREPARER_ID, RM_ID FROM SML_CA WHERE ca_number LIKE 'CAR/19/0001/00122/00009171' ; 

SELECT * FROM SML_CA WHERE 

Customer: TRANG I2109
CAR: CAR/19/0001/00122/00009171( Pending Approval)
caklinh001 |Credit Approver

--sql1
SELECT * FROM SML_USER WHERE login_id like '%le ngoc quoc dat%' ; 
-- sql 2 
SELECT * FROM SML_CA WHERE ca_number LIKE '%CMM/22/9002/00924/04926052%' ;
--sql 2
SELECT 
          distinct trx.user_state, trx.originator_id, ooe.group_name ooe_grp_name, 
          c.customer_name, 
          to_nchar(fp.ca_number) || ' - ' || fp.description AS fp_desc, 
          fp.id fp_id, 
          fp.creation_date fp_creation_date, 
          fp.last_update_date fp_last_update_date, 
          trx.user_trx_type || '(Credit Memo)' app_type, 
          trx.creation_date date_first_submitted, 
          trx.id, 
          info.event as trx_event, 
          (
            select full_name from sml_user 
            where id = trx.last_owner_id
          ) as last_owner_name, 
          (
            select full_name from sml_user where id = trx.next_owner_id) as next_owner_name, 
          uo.full_name orignator_name, 
          fp.pending_valuation_ind, 
          (
            SELECT code_value from code_value va where va.ID = to_number(fp.car_type)
          ) as car_type, 
          
          fp.INTEGRATION_STS_1 as stp_status, 
          (
            SELECT 
              Max(trail.last_update_date) 
            FROM 
              SML_FP_TRAILS trail 
            WHERE 
              trail.ca_id = fp.id 
              and state not in ('ABORTED', 'DRAFT') 
              and last_state is not null
          ) as date_last_submitted, 
            trx.*
        FROM 
          sml_ca fp 
          inner join sml_customer c ON fp.borrower_id = c.id 
          LEFT join sml_ooe_group_member mem ON mem.customer_id = c.id 
          LEFT join sml_ooe_group ooe ON ooe.id = mem.ooe_group_id 
          inner join sml_credit_memo cm ON cm.ca_id = fp.id 
          inner join sml_prod_package pp ON fp.prod_package_id = pp.id 
          inner join sml_fp_folder_details fd ON fd.credit_memo_id = cm.id 
          inner join sml_trx trx ON trx.stage_ref_id = fd.fp_folder_id 
          AND (SELECT ID FROM SML_USER WHERE full_name like '%le ngoc quoc dat%' ) IN (
            trx.originator_id, trx.next_owner_id
          ) 
          AND trx.state IN (
            'DECLINED', 'RETURNED', 'APPROVED', 
            'LO_GEN', 'PEND_LO_GEN', 'LO_ACCEPT', 
            'LO_REJECT', 'LO_NOT_REQ'
          ) 
          inner join sml_trx_type trx_type ON trx_type.id = trx.trx_type_id 
          AND trx_type.trx_group = 'CREDIT_MEMO_TRX' 
          inner join sml_trx_ext_info info ON info.trx_type_id = trx_type.id 
          AND info.state = trx.state 
          inner join sml_user uo ON uo.id = trx.originator_id 
        WHERE 
          fp.PREPARER_ID IN (SELECT ID FROM SML_USER WHERE full_name like '%le ngoc quoc dat%' );
--sql 3 
SELECT 
      distinct null USER_STATE, 
      0 ORIGINATOR_ID, 
      ff.id FP_ID, 
      ff.CREATION_DATE FP_CREATION_DATE, 
      ff.LAST_UPDATE_DATE FP_LAST_UPDATE_DATE, 
      0 TOTAL_AMT, ff.*
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
        trx.state IN (
          'DECLINED', 'RETURNED', 'APPROVED', 
          'LO_GEN', 'PEND_LO_GEN'
        ) 
        AND (
          trx.originator_id = (SELECT ID FROM SML_USER WHERE full_name like '%le ngoc quoc dat%' )
          OR trx.next_owner_id = (SELECT ID FROM SML_USER WHERE full_name like '%le ngoc quoc dat%' )
        ) 
        AND trx.trx_type_id in (
          select 
            distinct accessFunction.trx_type_id 
          from 
            sml_team team 
            inner join sml_team_member teamMember on teamMember.team_id = team.id 
            and team.status = 'ACTIVE' 
            and teamMember.user_id = (SELECT ID FROM SML_USER WHERE full_name like '%le ngoc quoc dat%' ) 
            inner join sml_user_access_function userAccessFunc on userAccessFunc.profile_id = teamMember.profile_id 
            inner join sml_access_function accessFunction on accessFunction.id = userAccessFunc.access_function_id 
          where 
            accessFunction.trx_type_id is not null 
            and accessFunction.name LIKE '%:create-fp%'
        )  
        AND trx.stage_ref_id = ff.id 
        AND trx.trx_type_id = trx_type.id 
        AND trx_type.id = trx_ext_info.trx_type_id 
        AND trx.state = trx_ext_info.state 
        AND usr_org.id = trx.originator_id
-- sql 4




-- find role RMTL
SELECT E.TEAM_TYPE_ID, * 
FROM cms_user A
JOIN CMS_TEAM_MEMBER B ON A.USER_ID = B.USER_ID 
JOIN CMS_TEAM_MEMBERSHIP C ON b.team_membership_id = c.team_membership_id
JOIN CMS_TEAM_TYPE_MEMBERSHIP D ON c.team_type_membership_id = d.team_type_membership_id
JOIN CMS_TEAM_TYPE E ON D.TEAM_TYPE_ID = E.TEAM_TYPE_ID
WHERE LOWER(A.login_id) = 'rmtlklinh001' ;
--SUCCESS: 
--CUSC106008	clims123     
--CUSC106007	2F795DEE489136705829D30375FF659C89415983
--CUSC106006	637D9BB4FF56A71F9F21

--SEND

--sql1
select * from sml_user u where lower(u.login_id) = 'datlnq' and u.master_id is null ; 
-- sql 2 
SELECT * FROM SML_CA WHERE ca_number LIKE '%CMM/22/9002/00924/04926052%' ;
--sql 2
SELECT 
          distinct trx.user_state, trx.originator_id, ooe.group_name ooe_grp_name, 
          c.customer_name, 
          to_nchar(fp.ca_number) || ' - ' || fp.description AS fp_desc, 
          fp.id fp_id, 
          fp.creation_date fp_creation_date, 
          fp.last_update_date fp_last_update_date, 
          trx.user_trx_type || '(Credit Memo)' app_type, 
          trx.creation_date date_first_submitted, 
          trx.id, 
          info.event as trx_event, 
          (
            select full_name from sml_user 
            where id = trx.last_owner_id
          ) as last_owner_name, 
          (
            select full_name from sml_user where id = trx.next_owner_id) as next_owner_name, 
          uo.full_name orignator_name, 
          fp.pending_valuation_ind, 
          (
            SELECT code_value from code_value va where va.ID = to_number(fp.car_type)
          ) as car_type, 
          
          fp.INTEGRATION_STS_1 as stp_status, 
          (
            SELECT 
              Max(trail.last_update_date) 
            FROM 
              SML_FP_TRAILS trail 
            WHERE 
              trail.ca_id = fp.id 
              and state not in ('ABORTED', 'DRAFT') 
              and last_state is not null
          ) as date_last_submitted, 
            trx.*
        FROM 
          sml_ca fp 
          inner join sml_customer c ON fp.borrower_id = c.id 
          LEFT join sml_ooe_group_member mem ON mem.customer_id = c.id 
          LEFT join sml_ooe_group ooe ON ooe.id = mem.ooe_group_id 
          inner join sml_credit_memo cm ON cm.ca_id = fp.id 
          inner join sml_prod_package pp ON fp.prod_package_id = pp.id 
          inner join sml_fp_folder_details fd ON fd.credit_memo_id = cm.id 
          inner join sml_trx trx ON trx.stage_ref_id = fd.fp_folder_id 
          AND (select ID from sml_user u where lower(u.login_id) = 'datlnq' and u.master_id is null ) IN (
            trx.originator_id, trx.next_owner_id
          ) 
          AND trx.state IN (
            'DECLINED', 'RETURNED', 'APPROVED', 
            'LO_GEN', 'PEND_LO_GEN', 'LO_ACCEPT', 
            'LO_REJECT', 'LO_NOT_REQ'
          ) 
          inner join sml_trx_type trx_type ON trx_type.id = trx.trx_type_id 
          AND trx_type.trx_group = 'CREDIT_MEMO_TRX' 
          inner join sml_trx_ext_info info ON info.trx_type_id = trx_type.id 
          AND info.state = trx.state 
          inner join sml_user uo ON uo.id = trx.originator_id 
        WHERE 
          fp.PREPARER_ID IN (select ID from sml_user u where lower(u.login_id) = 'datlnq' and u.master_id is null );
--sql 3 
SELECT 
      distinct null USER_STATE, 
      0 ORIGINATOR_ID, 
      ff.id FP_ID, 
      ff.CREATION_DATE FP_CREATION_DATE, 
      ff.LAST_UPDATE_DATE FP_LAST_UPDATE_DATE, 
      0 TOTAL_AMT, ff.*
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
        trx.state IN (
          'DECLINED', 'RETURNED', 'APPROVED', 
          'LO_GEN', 'PEND_LO_GEN'
        ) 
        AND (
          trx.originator_id = (select ID from sml_user u where lower(u.login_id) = 'datlnq' and u.master_id is null  )
          OR trx.next_owner_id = (select ID from sml_user u where lower(u.login_id) = 'datlnq' and u.master_id is null )
        ) 
        AND trx.trx_type_id in (
          select 
            distinct accessFunction.trx_type_id 
          from 
            sml_team team 
            inner join sml_team_member teamMember on teamMember.team_id = team.id 
            and team.status = 'ACTIVE' 
            and teamMember.user_id = (select ID from sml_user u where lower(u.login_id) = 'datlnq' and u.master_id is null ) 
            inner join sml_user_access_function userAccessFunc on userAccessFunc.profile_id = teamMember.profile_id 
            inner join sml_access_function accessFunction on accessFunction.id = userAccessFunc.access_function_id 
          where 
            accessFunction.trx_type_id is not null 
            and accessFunction.name LIKE '%:create-fp%'
        )  
        AND trx.stage_ref_id = ff.id 
        AND trx.trx_type_id = trx_type.id 
        AND trx_type.id = trx_ext_info.trx_type_id 
        AND trx.state = trx_ext_info.state 
        AND usr_org.id = trx.originator_id
      )


      -- DELETE
      DELETE FROM SML_CA WHERE ID = 202204070005567405;
      COMMIT ;
