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

    --SCI_LSP_LMP_PROFILE is saved by limitprofile limitProfileActualTrxHandler
        There are two customer profile in SCI_LE_SUB_PROFILE