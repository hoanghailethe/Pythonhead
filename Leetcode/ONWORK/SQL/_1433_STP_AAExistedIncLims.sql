-- Querried
select * from sml_ca ca where ca.ca_number = 'CAR/22/9002/00622/04998786'
SELECT llp_bca_ref_num -- application no 							
FROM (
        SELECT llp_bca_ref_num,
            cms_aa_id, sci_lsp_aa_profile.*
        FROM sci_lsp_aa_profile
        WHERE llp_le_id = 3017992228 --CIF                              
            AND llp_bca_ref_num IS NOT NULL
            AND (
                cms_aa_status <> 'DELETED'
                OR (
                    cms_aa_id NOT IN (
                        SELECT reference_id
                        FROM TRANSACTION
                        WHERE transaction_type = 'AA_PROFILE'
                            AND status <> 'ACTIVE'
                    )
                )
            )
        ORDER BY cms_aa_id DESC
    )
WHERE ROWNUM < 2;
 --customerID
SELECT CMS_LE_SUB_PROFILE_ID
FROM SCI_LE_SUB_PROFILE
    INNER JOIN SCI_LE_MAIN_PROFILE ON SCI_LE_SUB_PROFILE.CMS_LE_MAIN_PROFILE_ID = SCI_LE_MAIN_PROFILE.CMS_LE_MAIN_PROFILE_ID
WHERE LSP_LE_ID LIKE '%3017992228%';

SELECT *
FROM TRANSACTION
WHERE transaction_type = 'AA_PROFILE'
    AND CUSTOMER_ID IN (
        SELECT CMS_LE_SUB_PROFILE_ID
        FROM SCI_LE_SUB_PROFILE
            INNER JOIN SCI_LE_MAIN_PROFILE ON SCI_LE_SUB_PROFILE.CMS_LE_MAIN_PROFILE_ID = SCI_LE_MAIN_PROFILE.CMS_LE_MAIN_PROFILE_ID
        WHERE LSP_LE_ID LIKE '%3017992228%'
    );

SELECT *
FROM STAGE_LIMIT_PROFILE
WHERE LOS_BCA_REF_NUM LIKE '%CAR/22/9002/00622/04998786%';
SELECT *
FROM STAGE_LIMIT_PROFILE
WHERE llp_bca_ref_num LIKE '3017992228';

-- CIF / Application NO
SELECT *
FROM STAGE_LIMIT_PROFILE
WHERE llp_bca_ref_num IN (
        SELECT llp_bca_ref_num -- application no 							
        FROM (
                SELECT llp_bca_ref_num,
                    cms_aa_id
                FROM sci_lsp_aa_profile
                WHERE llp_le_id = 3017992228 --CIF                              
                    AND llp_bca_ref_num IS NOT NULL
                    AND (
                        cms_aa_status <> 'DELETED'
                        OR (
                            cms_aa_id NOT IN (
                                SELECT reference_id
                                FROM TRANSACTION
                                WHERE transaction_type = 'AA_PROFILE'
                                    AND status <> 'ACTIVE'
                            )
                        )
                    )
                ORDER BY cms_aa_id DESC
            )
        WHERE ROWNUM < 2
    );


-- THAM KHẢO -BASE
--FIND TRANSACTION TIMEs of change
select * from transaction where transaction_type = 'COL' and reference_id in (select cms_collateral_id from cms_security where security_no = 'CS202208110022639629');
select * from trans_history where transaction_id in (select transaction_id from transaction where transaction_type = 'COL' and reference_id in (select cms_collateral_id from cms_security where security_no = 'CS202208110022639629'));
select * from CMS_STAGE_CHARGE_DETAIL where cms_collateral_id in (select cms_collateral_id from CMS_STAGE_SECURITY where security_no = 'CS202208110022639629');
select * from CMS_STAGE_SECURITY where security_no = 'CS202208110022639629';
--CMS
select * from cms_security where security_no = 'AB202208160022658657';
select * from cms_charge_detail where cms_collateral_id in (select cms_collateral_id from cms_security where security_no = 'AB202208160022658657');
select * from transaction where transaction_type = 'COL' and reference_id in (select cms_collateral_id from cms_security where security_no = 'AB202208160022658657');
select * from trans_history where transaction_id in (select transaction_id from transaction where transaction_type = 'COL' and reference_id in (select cms_collateral_id from cms_security where security_no = 'AB202208160022658657'));
select * from CMS_STAGE_CHARGE_DETAIL where cms_collateral_id in (select cms_collateral_id from CMS_STAGE_SECURITY where security_no = 'AB202208160022658657');
select * from CMS_STAGE_SECURITY where security_no = 'AB202208160022658657';

select * from transaction where transaction_type = 'COL' and reference_id in (20220726020559087, 20220726020559085);
select * from TRANS_HISTORY where transaction_id in (select transaction_id from transaction where transaction_type = 'COL' and reference_id in (20220726020559087, 20220726020559085));



-- COVERT to SQL
Substitute #
-- FROM
SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID = 202205250022068591
-- TO
select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%'


--ADD CHECKING TRANSATACTION INFORMATION
SELECT * FROM STAGE_LIMIT_PROFILE WHERE LOS_BCA_REF_NUM LIKE '%CAR/22/9002/00622/04998786%';
select * from CMS_STAGE_CHARGE_DETAIL where cms_collateral_id in (Select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%');
select * from CMS_STAGE_SECURITY where cms_collateral_id in (Select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%');
select * from transaction where reference_id in (Select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%');
select * from TRANS_HISTORY where transaction_id in (select transaction_id from transaction where reference_id in (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%'));


-- SELECT ALL RELATED INFORMATION TO THIS CAR

Select * from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ;

SELECT * FROM cms_checklist 
JOIN cms_security ON cms_checklist.cms_collateral_id  = cms_security.cms_collateral_id 
WHERE cms_security.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT * FROM CMS_CHECKLIST_ITEM WHERE CHECKLIST_ID = (SELECT CHECKLIST_ID FROM cms_checklist 
JOIN cms_security ON cms_checklist.cms_collateral_id  = cms_security.cms_collateral_id 
WHERE cms_security.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' )) ;


SELECT lm.* 
from sci_lsp_lmt_profile lm , CMS_CA_COLLATERAL_MAP map
where LM.CMS_LSP_LMT_PROFILE_ID = map.CMS_LSP_LMT_PROFILE_ID
AND map.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT * FROM CMS_ASSET WHERE cms_asset.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' );

SELECT * FROM CMS_CHARGE_DETAIL chrg WHERE chrg.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT * FROM CMS_FAC_RELATIONSHIP fac, CMS_CHARGE_DETAIL cd
WHERE fac.CMS_REF_ID = cd.CMS_REF_ID
AND cd.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT * FROM cms_facility_master fm
LEFT JOIN CMS_FAC_RELATIONSHIP fac
ON fm.ID = fac.CMS_FAC_MASTER_ID
JOIN CMS_CHARGE_DETAIL cd
ON fac.CMS_REF_ID = cd.CMS_REF_ID
AND cd.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT * FROM CMS_LIMIT_CHARGE_MAP CM, CMS_CHARGE_DETAIL C 
WHERE C.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) AND
C.CHARGE_DETAIL_ID = CM.CHARGE_DETAIL_ID;

SELECT * FROM CMS_LIMIT_SECURITY_MAP lsm WHERE lsm.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT lmt.* FROM SCI_LSP_APPR_LMTS lmt, CMS_LIMIT_SECURITY_MAP lsm
WHERE lmt.CMS_LSP_APPR_LMTS_ID = lsm.CMS_LSP_APPR_LMTS_ID
AND lsm.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT cms_cust_doc.* FROM   cms_checklist  
LEFT OUTER JOIN  cms_cust_doc  ON  cms_checklist.checklist_id  = cms_cust_doc.checklist_id    
JOIN cms_security ON cms_checklist.cms_collateral_id  = cms_security.cms_collateral_id 
WHERE cms_security.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;


SELECT cms_cust_doc_item.* FROM   cms_checklist  
LEFT OUTER JOIN  cms_cust_doc  ON  cms_checklist.checklist_id  = cms_cust_doc.checklist_id   
LEFT OUTER JOIN  cms_cust_doc_item ON cms_cust_doc_item.CUSTODIAN_DOC_ID = cms_cust_doc.CUSTODIAN_DOC_ID
JOIN cms_security ON cms_checklist.cms_collateral_id  = cms_security.cms_collateral_id 
WHERE cms_security.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;


SELECT sci_le_sub_profile.* FROM   cms_checklist  
LEFT OUTER JOIN  cms_cust_doc  ON  cms_checklist.checklist_id  = cms_cust_doc.checklist_id    
LEFT OUTER JOIN  sci_le_sub_profile  ON  sci_le_sub_profile.CMS_LE_SUB_PROFILE_ID  = cms_checklist.CMS_LMP_SUB_PROFILE_ID   
JOIN cms_security ON cms_checklist.cms_collateral_id  = cms_security.cms_collateral_id 
WHERE cms_security.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT sci_le_main_profile.*  FROM  cms_checklist  
LEFT OUTER JOIN  cms_cust_doc  ON  cms_checklist.checklist_id  = cms_cust_doc.checklist_id    
LEFT OUTER JOIN  sci_le_sub_profile  ON  sci_le_sub_profile.CMS_LE_SUB_PROFILE_ID  = cms_checklist.CMS_LMP_SUB_PROFILE_ID   
LEFT OUTER JOIN  sci_le_main_profile  ON  sci_le_main_profile.CMS_LE_MAIN_PROFILE_ID  =sci_le_sub_profile.CMS_LE_MAIN_PROFILE_ID
JOIN cms_security ON cms_checklist.cms_collateral_id  = cms_security.cms_collateral_id 
WHERE cms_security.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;


SELECT SCI_PLEDGOR_DTL.* 
FROM SCI_PLEDGOR_DTL, SCI_SEC_PLDGR_MAP, CMS_SECURITY
WHERE SCI_PLEDGOR_DTL.CMS_PLEDGOR_DTL_ID = SCI_SEC_PLDGR_MAP.CMS_PLEDGOR_DTL_ID 
AND SCI_SEC_PLDGR_MAP.CMS_COLLATERAL_ID = CMS_SECURITY.CMS_COLLATERAL_ID 
AND cms_security.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

SELECT SCI_SEC_PLDGR_MAP.*
FROM SCI_PLEDGOR_DTL, SCI_SEC_PLDGR_MAP, CMS_SECURITY
WHERE SCI_PLEDGOR_DTL.CMS_PLEDGOR_DTL_ID = SCI_SEC_PLDGR_MAP.CMS_PLEDGOR_DTL_ID 
	AND SCI_SEC_PLDGR_MAP.CMS_COLLATERAL_ID = CMS_SECURITY.CMS_COLLATERAL_ID 
	AND cms_security.CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ) ;

-- add more infor about SECURITY and TRANSACTION 8/19/2022
SELECT * FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%' ); 

SELECT llp_bca_ref_num, sci_lsp_aa_profile.*
        FROM sci_lsp_aa_profile
        WHERE llp_le_id = 3017992228 --CIF                              
            AND llp_bca_ref_num IS NOT NULL
            AND (
                cms_aa_status <> 'DELETED'
                OR (
                    cms_aa_id NOT IN (
                        SELECT reference_id
                        FROM TRANSACTION
                        WHERE transaction_type = 'AA_PROFILE'
                            AND status <> 'ACTIVE'
                    )
                )
            )
        ORDER BY cms_aa_id DESC;

SELECT llp_bca_ref_num, sci_lsp_aa_profile.* FROM sci_lsp_aa_profile
WHERE llp_le_id = 3017992228 --CIF                              
AND llp_bca_ref_num IS NOT NULL
ORDER BY cms_aa_id DESC;

SELECT reference_id, 
    TRANSACTION.*
    FROM TRANSACTION
    WHERE transaction_type = 'AA_PROFILE'
        AND status <> 'ACTIVE' AND reference_id IN ( SELECT cms_aa_id FROM sci_lsp_aa_profile WHERE llp_bca_ref_num= 3017992228) ; 

SELECT * FROM TRANSACTION WHERE transaction_type = 'AA_PROFILE' AND reference_id IN ( SELECT cms_aa_id FROM sci_lsp_aa_profile WHERE llp_bca_ref_num= 3017992228) ;

SELECT SCI_LE_SUB_PROFILE.* FROM SCI_LE_SUB_PROFILE WHERE LSP_LE_ID LIKE '%3017992228%';

SELECT SCI_LE_MAIN_PROFILE.*
FROM SCI_LE_SUB_PROFILE
INNER JOIN SCI_LE_MAIN_PROFILE ON SCI_LE_SUB_PROFILE.CMS_LE_MAIN_PROFILE_ID = SCI_LE_MAIN_PROFILE.CMS_LE_MAIN_PROFILE_ID
WHERE LSP_LE_ID LIKE '%3017992228%';

SELECT *
FROM TRANSACTION
WHERE transaction_type = 'AA_PROFILE'
    AND CUSTOMER_ID IN (
        SELECT CMS_LE_SUB_PROFILE_ID
        FROM SCI_LE_SUB_PROFILE
            INNER JOIN SCI_LE_MAIN_PROFILE ON SCI_LE_SUB_PROFILE.CMS_LE_MAIN_PROFILE_ID = SCI_LE_MAIN_PROFILE.CMS_LE_MAIN_PROFILE_ID
        WHERE LSP_LE_ID LIKE '%3017992228%'
    );

select * from TRANS_HISTORY where transaction_id in (select transaction_id from transaction WHERE transaction_type = 'AA_PROFILE'
    AND CUSTOMER_ID IN (
        SELECT CMS_LE_SUB_PROFILE_ID
        FROM SCI_LE_SUB_PROFILE
            INNER JOIN SCI_LE_MAIN_PROFILE ON SCI_LE_SUB_PROFILE.CMS_LE_MAIN_PROFILE_ID = SCI_LE_MAIN_PROFILE.CMS_LE_MAIN_PROFILE_ID
        WHERE LSP_LE_ID LIKE '%3017992228%'
    ));


--asset Table:
SELECT * FROM CMS_CASH WHERE CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%');
-- SELECT * FROM CMS_CASH_DEPOSIT WHERE CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%');
-- SELECT * FROM CMS_CASH_MARGIN WHERE CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%');
-- SELECT * FROM CMS_DEAL_CASH WHERE CMS_COLLATERAL_ID IN (select CMS_COLLATERAL_ID from cms_ca_collateral_map map where map.los_bca_ref_num LIKE '%CAR/22/9002/00622/04998786%');


SELECT * FROM sci_le_sub_profile WHERE 

-- find checklist Type Customer
SELECT * FROM cms_checklist WHERE CMS_LMP_SUB_PROFILE_ID IN (20220524000801654, 20220524000801655) ; 

-- DELETE  822/2022 
DELETE FROM sci_le_main_profile WHERE CMS_LE_MAIN_PROFILE_ID = 20220524023211720;
DELETE FROM sci_le_sub_profile WHERE CMS_LE_SUB_PROFILE_ID = 20220524000801655;
COMMIT;

