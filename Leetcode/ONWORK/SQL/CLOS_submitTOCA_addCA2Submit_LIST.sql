SELECT 
      p.id, 
      p.cto_code ctocode, 
      p.cto_code ctocodevalue, 
      (
        SELECT 
          code_value 
        FROM 
          code_value 
        WHERE 
          id = u.branch_num
      ) branchname, 
      (
        SELECT 
          code_value 
        FROM 
          code_value 
        WHERE 
          id = u.centre_code
      ) centrename, 
      p.master_id masterid, 
      t.id teamid, 
      u.login_id loginid, 
      u.id userid, 
      u.full_name username, 
      (
        SELECT 
          code_value 
        FROM 
          code_value 
        WHERE 
          id = t.role_id
      ) rolename, 
      t.role_id roleid, 
      (
        SELECT 
          code 
        FROM 
          code_value 
        WHERE 
          id = t.role_id
      ) rolecode, 
      t.name teamname 
    FROM 
      sml_team_member m 
      INNER JOIN sml_user u ON m.user_id = u.id 
      INNER JOIN sml_user_profile p ON p.id = m.profile_id 
      INNER JOIN sml_team t ON t.id = m.team_id 
      AND t.status = 'ACTIVE' 
      AND t.master_id IS NULL 
      AND u.deprecated = 'N' 
      AND u.status = 'ACTIVE' 
      AND u.DISABLED = 'N' 
      AND u.id_activation_ind = 'Y' 
      AND p.status = 'ACTIVE' 
      AND p.master_id IS NULL 
      AND 'SUB_BRANCH' = (
        SELECT 
          code 
        FROM 
          code_value 
        where 
          id = t.level_id
      ) 
      AND  'CA' = (
        SELECT 
          code 
        FROM 
          code_value 
        where 
          id = u.user_designation_id        -- ROLE
      ) 
      AND t.id IN (201509210000001484) ; --PARENT TEAM ID or child if not have
      --RES : 
-- 201509210000001484	caklinh001
-- 201509210000001484	caklinh002


-- FIND TEAM ID of USER: 
Select t.id
from  sml_team_member m
INNER JOIN sml_user         u ON m.user_id = u.id
INNER JOIN sml_user_profile p ON p.id = m.profile_id
INNER JOIN sml_team         t ON t.id = m.team_id
where (login_id) = 'rmklinh001';
-- 201509210000001480       CHILD TEAM

 List<Long> parentTeamIdList = getAllParentTeamID(criteria.getTeamId(), criteria.getTeamLevel(), criteria.getTeamRole());
 TeamID = child_ID ; Team_LEVEL = 'SUB_BRANCH' ; teamROLE = 'CA' ;

-- Search PARENT TEAM
  SELECT team_child.parent_id AS id, team.name 
  FROM ( SELECT DISTINCT stc.parent_id, stc.child_id FROM sml_team_child stc 
            START WITH stc.child_id = 201509210000001480 CONNECT BY PRIOR stc.parent_id = stc.child_id) team_child 
            INNER JOIN sml_team team             
            ON team.id = team_child.parent_id AND team.master_id IS NULL AND team.status = 'ACTIVE' 
            WHERE 'SUB_BRANCH' = (SELECT code FROM code_value WHERE id = team.level_id) 
             AND 'CA' IN ( 
            SELECT REGEXP_SUBSTR ((SELECT ext_value3 FROM code_value WHERE id = team.role_id), '[^, ]+', 1, LEVEL) FROM DUAL 
            CONNECT BY REGEXP_SUBSTR ((SELECT ext_value3 FROM code_value WHERE id = team.role_id), '[^, ]+', 1, LEVEL) IS NOT NULL 
            ) ;
-- 201509210000001484	CAKLINH001 TEAM 

-- How to add in SIT OKI NOW HOW TO ADD SOME ONE TO A TEAM ? 
1. CHECK HAS PARENT 

FROM sml_team_child stc START WITH stc.child_id = ?

2. Muốn chuyển thêm 1 CA về TEAM 
    - TÌM 1 CA ACTIVE
    - XĐ team ID MUỐN chuyển tới
    - Change id trong sml_team về ID trên 

    SELECT t.id
    FROM 
      sml_team_member m 
      INNER JOIN sml_user u ON m.user_id = u.id 
      INNER JOIN sml_user_profile p ON p.id = m.profile_id 
      INNER JOIN sml_team t ON t.id = m.team_id 
    WHERE u.login_id = '' ;


    PHAI THAY DOI O sml_team_member thi DUNG HON 
    ADD vao TEAMID

    PHAI CHANGE TEAM_ID = ... O TRONG BANG sml_team_member = id cua team muon chuyen
    SELECT m.team_id, m.* FROM 
      sml_team_member m 
      INNER JOIN sml_user u ON m.user_id = u.id 
      INNER JOIN sml_user_profile p ON p.id = m.profile_id 
      INNER JOIN sml_team t ON t.id = m.team_id 
    WHERE u.login_id = '' ;


SELECT * FROM SML_CA WHERE ca_number = 'CAR/23/0001/00122/00009328' ;

SELECT * FROM sml_team_member ; 
--20130524000236	0	SML	24-MAY-13	SML	24-MAY-13	20130524000049	20130524000242	20130524000230
UPDATE sml_team_member SET TEAM_ID =20130524000050 WHERE ID =20130524000236 ;
ROLLBACK ;
COMMIT ;

-- CA TODO SQ:
SELECT 
  * 
FROM 
  (
    SELECT 
      temp3.*, 
      ROWNUM rnum 
    FROM 
      (
        SELECT 
          * 
        FROM 
          (
            SELECT 
              temp0.* 
            FROM 
              (
                SELECT 
                  user_state, 
                  refer_count, 
                  originator_id, 
                  ooe_grp_name, 
                  folder_id, 
                  fp_id, 
                  fp_creation_date, 
                  date_first_submitted, 
                  id, 
                  stage_ref_id, 
                  trx_group_name, 
                  last_remarks, 
                  last_owner_name, 
                  next_owner_name, 
                  trx_event, 
                  next_owner_id, 
                  last_owner_id, 
                  user_trx_desc, 
                  user_trx_parameter, 
                  user_trx_date, 
                  orignator_name, 
                  user_trx_status, 
                  customer_name, 
                  fp_desc, 
                  pp_name, 
                  campaign_name, 
                  app_type, 
                  car_type, 
                  total_amt 
                FROM 
                  (
                    SELECT 
                      distinct trx.user_state user_state, 
                      ff.refer_count AS refer_count, 
                      trx.originator_id originator_id, 
                      (
                        SELECT 
                          group_name 
                        FROM 
                          sml_ooe_group 
                        WHERE 
                          id = ff.ooe_group_id
                      ) AS ooe_grp_name, 
                      ff.id as folder_id, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        det.fp_id, 
                        null
                      ) as fp_id, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            fp.creation_date 
                          FROM 
                            sml_ca fp 
                          WHERE 
                            id = det.fp_id
                        ), 
                        null
                      ) as fp_creation_date, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            Min(trail.last_update_date) 
                          FROM 
                            SML_FP_TRAILS trail 
                          WHERE 
                            trail.ca_id = fp.id 
                            and state not in ('ABORTED', 'DRAFT')
                        ), 
                        NULL
                      ) as date_first_submitted, 
                      trx.id as id, 
                      trx.stage_ref_id as stage_ref_id, 
                      trx_type.trx_group as trx_group_name, 
                      trx.remarks as last_remarks, 
                      (
                        select 
                          owner.full_name 
                        from 
                          sml_user owner 
                        where 
                          owner.id = trx.last_owner_id
                      ) as last_owner_name, 
                      (
                        select 
                          owner.full_name 
                        from 
                          sml_user owner 
                        where 
                          owner.id = trx.next_owner_id
                      ) as next_owner_name, 
                      trx_ext_info.event as trx_event, 
                      trx.next_owner_id as next_owner_id, 
                      trx.last_owner_id as last_owner_id, 
                      trx_type.description as user_trx_desc, 
                      trx.user_trx_type as user_trx_parameter, 
                      trx.last_update_date as user_trx_date, 
                      usr_org.full_name as orignator_name, 
                      trx.state as user_trx_status, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            customer_name 
                          FROM 
                            sml_customer 
                          WHERE 
                            id IN (
                              SELECT 
                                borrower_id 
                              FROM 
                                sml_ca 
                              WHERE 
                                id = det.fp_id
                            )
                        ), 
                        null
                      ) as customer_name, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            to_nchar(fp.ca_number) || ' - ' || fp.description 
                          FROM 
                            sml_ca fp 
                          WHERE 
                            id = det.fp_id
                        ), 
                        null
                      ) as fp_desc, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          CASE (
                            SELECT 
                              pp.type 
                            FROM 
                              sml_prod_package pp 
                            WHERE 
                              pp.id = fp.prod_package_id
                          ) WHEN 'P' THEN (
                            SELECT 
                              to_nchar(pp.type) 
                            FROM 
                              sml_prod_package pp 
                            WHERE 
                              pp.id = fp.prod_package_id
                          ) ELSE (
                            SELECT 
                              to_nchar(pp.name) 
                            FROM 
                              sml_prod_package pp, 
                              sml_prod_package campaign 
                            where 
                              campaign.id = fp.prod_package_id 
                              AND campaign.package_id = pp.id
                          ) END
                        ), 
                        null
                      ) AS pp_name, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        COALESCE(
                          (
                            SELECT 
                              pp.NAME 
                            FROM 
                              sml_prod_package pp 
                            WHERE 
                              pp.TYPE = 'C' 
                              AND pp.id = fp.prod_package_id
                          ), 
                          to_nchar('-')
                        ), 
                        null
                      ) AS campaign_name, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            code_value 
                          FROM 
                            code_value 
                          WHERE 
                            id = fp.application_req_type
                        ), 
                        null
                      ) AS app_type, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            code_value 
                          from 
                            code_value va 
                          where 
                            va.ID = to_number(fp.car_type)
                        ), 
                        null
                      ) as car_type, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
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
                        ), 
                        null
                      ) total_amt 
                    FROM 
                      sml_fp_folder ff 
                      inner join sml_fp_folder_details det on det.fp_folder_id = ff.id 
                      inner join sml_ca fp ON det.fp_id = fp.id 
                      inner join sml_prod_package pp on fp.prod_package_id = pp.id 
                      inner join sml_customer c on fp.borrower_id = c.id 
                      inner join SML_TRX trx on trx.stage_ref_id = ff.id 
                      inner join SML_TRX_TYPE trx_type on trx.trx_type_id = trx_type.id 
                      inner join SML_TRX_EXT_INFO trx_ext_info on trx_type.id = trx_ext_info.trx_type_id 
                      AND trx.state = trx_ext_info.state 
                      inner join SML_USER usr_org on usr_org.id = trx.originator_id 
                    WHERE 
                      Nvl(fp.in_process_ind, 'N') != 'Y' 
                      AND (
                        trx.state IN ('PENDING_APPROVAL') 
                        AND trx_type.trx_group IN (
                          'APPROVAL_FOLDER_TRX', 'RATING_TRX'
                        ) 
                        AND (
                          ff.credit_deviation_count = 0 
                          or ff.credit_deviation_count is null
                        ) 
                        AND (
                          ff.prod_credit_deviation_count = 0 
                          or ff.prod_credit_deviation_count is null
                        ) 
                        AND (
                          (trx.next_owner_id = ?)
                        ) 
                        AND (
                          trx.trx_type_id in (
                            SELECT 
                              ID 
                            FROM 
                              SML_TRX_TYPE 
                            WHERE 
                              TRX_GROUP IN ('CREDIT_MEMO_TRX', 'RATING_TRX')
                          ) 
                          OR trx.trx_type_id in (
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
                              and (
                                accessFunction.name LIKE 'ca:todo%' 
                                OR accessFunction.name LIKE 'cc:todo%' 
                                OR accessFunction.name LIKE 'bod:todo%'
                              )
                          )
                        ) 
                        AND trx.stage_ref_id = ff.id 
                        AND trx.trx_type_id = trx_type.id 
                        AND trx_type.id = trx_ext_info.trx_type_id 
                        AND trx.state = trx_ext_info.state 
                        AND usr_org.id = trx.originator_id
                      )
                  ) temp1 
                UNION 
                SELECT 
                  user_state, 
                  refer_count, 
                  originator_id, 
                  ooe_grp_name, 
                  folder_id, 
                  fp_id, 
                  fp_creation_date, 
                  date_first_submitted, 
                  id, 
                  stage_ref_id, 
                  trx_group_name, 
                  last_remarks, 
                  last_owner_name, 
                  next_owner_name, 
                  trx_event, 
                  next_owner_id, 
                  last_owner_id, 
                  user_trx_desc, 
                  user_trx_parameter, 
                  user_trx_date, 
                  orignator_name, 
                  user_trx_status, 
                  customer_name, 
                  fp_desc, 
                  pp_name, 
                  campaign_name, 
                  app_type, 
                  car_type, 
                  total_amt 
                FROM 
                  (
                    SELECT 
                      distinct trx.user_state user_state, 
                      ff.refer_count AS refer_count, 
                      trx.originator_id originator_id, 
                      (
                        SELECT 
                          group_name 
                        FROM 
                          sml_ooe_group 
                        WHERE 
                          id = ff.ooe_group_id
                      ) AS ooe_grp_name, 
                      ff.id as folder_id, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        det.fp_id, 
                        null
                      ) as fp_id, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            fp.creation_date 
                          FROM 
                            sml_ca fp 
                          WHERE 
                            id = det.fp_id
                        ), 
                        null
                      ) as fp_creation_date, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            Min(trail.last_update_date) 
                          FROM 
                            SML_FP_TRAILS trail 
                          WHERE 
                            trail.ca_id = fp.id 
                            and state not in ('ABORTED', 'DRAFT')
                        ), 
                        NULL
                      ) as date_first_submitted, 
                      trx.id as id, 
                      trx.stage_ref_id as stage_ref_id, 
                      trx_type.trx_group as trx_group_name, 
                      trx.remarks as last_remarks, 
                      (
                        select 
                          owner.full_name 
                        from 
                          sml_user owner 
                        where 
                          owner.id = trx.last_owner_id
                      ) as last_owner_name, 
                      (
                        select 
                          owner.full_name 
                        from 
                          sml_user owner 
                        where 
                          owner.id = trx.next_owner_id
                      ) as next_owner_name, 
                      trx_ext_info.event as trx_event, 
                      trx.next_owner_id as next_owner_id, 
                      trx.last_owner_id as last_owner_id, 
                      trx_type.description as user_trx_desc, 
                      trx.user_trx_type as user_trx_parameter, 
                      trx.last_update_date as user_trx_date, 
                      usr_org.full_name as orignator_name, 
                      trx.state as user_trx_status, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            customer_name 
                          FROM 
                            sml_customer 
                          WHERE 
                            id IN (
                              SELECT 
                                borrower_id 
                              FROM 
                                sml_ca 
                              WHERE 
                                id = det.fp_id
                            )
                        ), 
                        null
                      ) as customer_name, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            to_nchar(fp.ca_number) || ' - ' || fp.description 
                          FROM 
                            sml_ca fp 
                          WHERE 
                            id = det.fp_id
                        ), 
                        null
                      ) as fp_desc, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          CASE (
                            SELECT 
                              pp.type 
                            FROM 
                              sml_prod_package pp 
                            WHERE 
                              pp.id = fp.prod_package_id
                          ) WHEN 'P' THEN (
                            SELECT 
                              to_nchar(pp.type) 
                            FROM 
                              sml_prod_package pp 
                            WHERE 
                              pp.id = fp.prod_package_id
                          ) ELSE (
                            SELECT 
                              to_nchar(pp.name) 
                            FROM 
                              sml_prod_package pp, 
                              sml_prod_package campaign 
                            where 
                              campaign.id = fp.prod_package_id 
                              AND campaign.package_id = pp.id
                          ) END
                        ), 
                        null
                      ) AS pp_name, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        COALESCE(
                          (
                            SELECT 
                              pp.NAME 
                            FROM 
                              sml_prod_package pp 
                            WHERE 
                              pp.TYPE = 'C' 
                              AND pp.id = fp.prod_package_id
                          ), 
                          to_nchar('-')
                        ), 
                        null
                      ) AS campaign_name, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            code_value 
                          FROM 
                            code_value 
                          WHERE 
                            id = fp.application_req_type
                        ), 
                        null
                      ) AS app_type, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
                        (
                          SELECT 
                            code_value 
                          from 
                            code_value va 
                          where 
                            va.ID = to_number(fp.car_type)
                        ), 
                        null
                      ) as car_type, 
                      Decode(
                        (
                          SELECT 
                            group_name 
                          FROM 
                            sml_ooe_group 
                          WHERE 
                            id = ff.ooe_group_id
                        ), 
                        NULL, 
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
                        ), 
                        null
                      ) total_amt 
                    FROM 
                      sml_fp_folder ff 
                      inner join sml_fp_folder_details det on det.fp_folder_id = ff.id 
                      inner join SML_CREDIT_MEMO memo on det.CREDIT_MEMO_ID = memo.id 
                      inner join sml_ca fp ON memo.CA_ID = fp.id 
                      inner join sml_prod_package pp on fp.prod_package_id = pp.id 
                      inner join sml_customer c on fp.borrower_id = c.id 
                      inner join SML_TRX trx on trx.stage_ref_id = ff.id 
                      inner join SML_TRX_TYPE trx_type on trx.trx_type_id = trx_type.id 
                      inner join SML_TRX_EXT_INFO trx_ext_info on trx_type.id = trx_ext_info.trx_type_id 
                      AND trx.state = trx_ext_info.state 
                      inner join SML_USER usr_org on usr_org.id = trx.originator_id 
                    WHERE 
                      Nvl(fp.in_process_ind, 'N') != 'Y' 
                      AND (
                        trx.state IN ('PENDING_APPROVAL') 
                        AND trx_type.trx_group = 'CREDIT_MEMO_TRX' 
                        AND (
                          ff.credit_deviation_count = 0 
                          or ff.credit_deviation_count is null
                        ) 
                        AND (
                          ff.prod_credit_deviation_count = 0 
                          or ff.prod_credit_deviation_count is null
                        ) 
                        AND (
                          (trx.next_owner_id = ?)
                        ) 
                        AND (
                          trx.trx_type_id in (
                            SELECT 
                              ID 
                            FROM 
                              SML_TRX_TYPE 
                            WHERE 
                              TRX_GROUP IN ('CREDIT_MEMO_TRX', 'RATING_TRX')
                          ) 
                          OR trx.trx_type_id in (
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
                              and (
                                accessFunction.name LIKE 'ca:todo%' 
                                OR accessFunction.name LIKE 'cc:todo%' 
                                OR accessFunction.name LIKE 'bod:todo%'
                              )
                          )
                        ) 
                        AND trx.stage_ref_id = ff.id 
                        AND trx.trx_type_id = trx_type.id 
                        AND trx_type.id = trx_ext_info.trx_type_id 
                        AND trx.state = trx_ext_info.state 
                        AND usr_org.id = trx.originator_id
                      )
                  ) temp2
              ) temp0
          ) 
        ORDER BY 
          user_trx_date DESC, 
          upper(ooe_grp_name) ASC, 
          upper(app_type) ASC
      ) temp3
  ) 
WHERE 
  rnum <= ? 
  AND rnum > ?
