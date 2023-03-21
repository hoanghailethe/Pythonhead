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


SELECT * FROM (
    SELECT ca.id 
    FROM SML_CA ca 
    START WITH ca.los_bca_ref_num = 'CAR/16/0001/00122/00007490' 
    CONNECT BY PRIOR ca.INHERITED_CA_ID = ca.id AND ca.INTERGRATION_HOST_2 IS NOT NULL ) ca_var_history

SML_AA_LIMIT_BANK_PROP ;
SML_FAC_CRED_DECISION ;

SELECT cred_decision.APPROVAL_EXCEPTION as ap_exc, ca_var_history.ca_no, ca_var_history.caid
    FROM SML_FACILITY fac
    LEFT JOIN SML_FAC_CRED_DECISION cred_decision 
        ON fac.id = cred_decision.facility_id
    RIGHT JOIN (
            SELECT ca.id as caid , ca.CA_NUMBER as ca_no
            FROM SML_CA ca 
            START WITH ca.CA_NUMBER = 'CAR/16/0001/00122/00007490' 
            CONNECT BY PRIOR ca.INHERITED_CA_ID = ca.id AND ca.INTEGRATION_HOST_2 IS NOT NULL ) ca_var_history
        ON ca_var_history.caid = fac.CA_ID 
    ORDER BY ca_var_history.caid ASC ;


SELECT aa_limit.id, limit_prop.APPROVAL_EXCEPTION as ap_exc, ca_var_history.ca_no, ca_var_history.caid
    FROM sml_aa_limit aa_limit
    LEFT JOIN SML_AA_LIMIT_BANK_PROP limit_prop 
        ON aa_limit.id = limit_prop.aa_limit_id
    RIGHT JOIN (
            SELECT ca.id as caid , ca.CA_NUMBER as ca_no
            FROM SML_CA ca 
            START WITH ca.CA_NUMBER = 'CAR/16/0001/00122/00007490' 
            CONNECT BY PRIOR ca.INHERITED_CA_ID = ca.id AND ca.INTEGRATION_HOST_2 IS NOT NULL ) ca_var_history
        ON ca_var_history.caid = aa_limit.ca_id
    ORDER BY ca_var_history.caid ASC ;


-- CMS
SELECT * FROM CMS_FAC_ADDITIONAL WHERE approval_exception IS NOT NULL ; 
SELECT * FROM SCI_LSP_AA_PROFILE WHERE approval_exception IS NOT NULL ; 

SELECT m.cms_lsp_appr_lmts_id
from CMS_FAC_ADDITIONAL a, cms_facility_master m
where m.ID = a.CMS_FAC_MASTER_ID AND a.approval_exception IS NOT NULL ;
--20221202000021981
20230302000021983
20210929000021973

SELECT * FROM sci_lsp_appr_lmts WHERE cms_lsp_appr_lmts_id IN (20221202000021981,20230302000021983,20210929000021973 ) ;
-- CAR/21/0001/00122/00009292
-- CAR/22/0001/00122/00009326
-- CAR/23/0001/00122/00009329

--0 PASS TESTING
SELECT cred_decision.APPROVAL_EXCEPTION as ap_exc, ca_var_history.ca_no, ca_var_history.caid
    FROM SML_FACILITY fac
    LEFT JOIN SML_FAC_CRED_DECISION cred_decision 
        ON fac.id = cred_decision.facility_id
    RIGHT JOIN (
            SELECT ca.id as caid , ca.CA_NUMBER as ca_no
            FROM SML_CA ca 
            START WITH ca.CA_NUMBER = 'CAR/21/0001/00122/00009292' 
            CONNECT BY PRIOR ca.INHERITED_CA_ID = ca.id AND ca.INTEGRATION_HOST_2 IS NOT NULL ) ca_var_history
        ON ca_var_history.caid = fac.CA_ID 
    ORDER BY ca_var_history.caid ASC ;


    SELECT aa_limit.id, limit_prop.APPROVAL_EXCEPTION as ap_exc, ca_var_history.ca_no, ca_var_history.caid
    FROM sml_aa_limit aa_limit
    LEFT JOIN SML_AA_LIMIT_BANK_PROP limit_prop 
        ON aa_limit.id = limit_prop.aa_limit_id
    RIGHT JOIN (
            SELECT ca.id as caid , ca.CA_NUMBER as ca_no
            FROM SML_CA ca 
            START WITH ca.CA_NUMBER = 'CAR/16/0001/00122/00007490' 
            CONNECT BY PRIOR ca.INHERITED_CA_ID = ca.id AND ca.INTEGRATION_HOST_2 IS NOT NULL ) ca_var_history
        ON ca_var_history.caid = aa_limit.ca_id
    ORDER BY ca_var_history.caid ASC ;
