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