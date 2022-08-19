UPDATE sml_ca stp_candidate
SET stp_candidate.version_time = (stp_candidate.version_time + 1),
    stp_candidate.last_update_date = SYSDATE,
    stp_candidate.integration_host_5 = ?,
    stp_candidate.integration_host_2 = ?
WHERE stp_candidate.id = (SELECT ID
FROM (
        SELECT CA.ID
        FROM SML_CA CA
        WHERE CA.INTEGRATION_STS_1 = 'I'
            AND CA.INTEGRATION_HOST_5 IS NULL
            AND CA.INTEGRATION_DATE_1 IS NOT NULL
            AND 0 = (
                SELECT COUNT(1)
                FROM SML_CA CA_X
                WHERE CA_X.INTEGRATION_STS_1 IN ('I', 'Q', 'G')
                    AND CA_X.INTEGRATION_HOST_5 IS NOT NULL
                    AND CA_X.BORROWER_ID = CA.BORROWER_ID
            )
            AND (
                (
                    SELECT COUNT(1)
                    FROM SML_FACILITY FAC
                    WHERE FAC.CA_ID = CA.ID
                ) + (
                    SELECT COUNT(1)
                    FROM SML_CA_COLLATERAL COLLINK
                    WHERE COLLINK.EXISTING_IND IN ('Y', 'N')
                        AND COLLINK.CA_ID = CA.ID
                )
            ) >= ?
            AND (
                (
                    SELECT COUNT(1)
                    FROM SML_FACILITY FAC
                    WHERE FAC.CA_ID = CA.ID
                ) + (
                    SELECT COUNT(1)
                    FROM SML_CA_COLLATERAL COLLINK
                    WHERE COLLINK.EXISTING_IND IN ('Y', 'N')
                        AND COLLINK.CA_ID = CA.ID
                )
            ) <= ?
        ORDER BY CA.INTEGRATION_DATE_1 ASC
    )
WHERE ROWNUM = 1);

SELECT ID
FROM (
        SELECT CA.ID
        FROM SML_CA CA
        WHERE CA.INTEGRATION_STS_1 = 'I'
            AND CA.INTEGRATION_HOST_5 IS NULL
            AND CA.INTEGRATION_DATE_1 IS NOT NULL
            AND 0 = (
                SELECT COUNT(1)
                FROM SML_CA CA_X
                WHERE CA_X.INTEGRATION_STS_1 IN ('I', 'Q', 'G')
                    AND CA_X.INTEGRATION_HOST_5 IS NOT NULL
                    AND CA_X.BORROWER_ID = CA.BORROWER_ID
            )
            AND (
                (
                    SELECT COUNT(1)
                    FROM SML_FACILITY FAC
                    WHERE FAC.CA_ID = CA.ID
                ) + (
                    SELECT COUNT(1)
                    FROM SML_CA_COLLATERAL COLLINK
                    WHERE COLLINK.EXISTING_IND IN ('Y', 'N')
                        AND COLLINK.CA_ID = CA.ID
                )
            ) >= ?
            AND (
                (
                    SELECT COUNT(1)
                    FROM SML_FACILITY FAC
                    WHERE FAC.CA_ID = CA.ID
                ) + (
                    SELECT COUNT(1)
                    FROM SML_CA_COLLATERAL COLLINK
                    WHERE COLLINK.EXISTING_IND IN ('Y', 'N')
                        AND COLLINK.CA_ID = CA.ID
                )
            ) <= ?
        ORDER BY CA.INTEGRATION_DATE_1 ASC
    )
WHERE ROWNUM = 1;


--change CIF customer
SELECT cif.*, ca.id
FROM    sml_doc doc
INNER JOIN sml_customer cif ON doc.los_cif_id = cif.cif_number
INNER JOIN sml_ca ca ON doc.ca_id = ca.id 
AND ca.CA_NUMBER = 'CAR/22/9001/00144/00011171' ;


DELETE SQL LinkFC

-- CHANGE CIF OF CUSTOMER in clims
SELECT dtl.CMS_PLEDGOR_DTL_ID, dtl.PLG_LE_ID 
FROM  SCI_PLEDGOR_DTL dtl, SCI_SEC_PLDGR_MAP, CMS_SECURITY
WHERE dtl.CMS_PLEDGOR_DTL_ID = SCI_SEC_PLDGR_MAP.CMS_PLEDGOR_DTL_ID 
	AND SCI_SEC_PLDGR_MAP.CMS_COLLATERAL_ID = CMS_SECURITY.CMS_COLLATERAL_ID 
    AND cms_security.CMS_COLLATERAL_ID IN ( SELECT CMS_COLLATERAL_ID FROM CMS_CA_COLLATERAL_MAP WHERE LOS_BCA_REF_NUM = 'CAR/13/0001/00106/0000802-004' ) ;


UPDATE sci_pledgor_dtl set pledgor_le_id  = 999999999 WHERE CMS_PLEDGOR_DTL_ID = 123124124 ;
COMMIT;


-- DELETE ON 8.16 
-- VCLOSPRODA 1438
DELETE FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID  = 20220726020559085;
DELETE FROM CMS_ASSET WHERE CMS_COLLATERAL_ID = 20220726020559085;
DELETE FROM CMS_ASSET_VEHICLE WHERE CMS_COLLATERAL_ID = 20220726020559085;
COMMIT;

--VCLOSPRODA 1434
DELETE FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID = 20220525020185210;
DELETE FROM SCI_SEC_PLDGR_MAP WHERE CMS_SEC_PLDGR_MAP_ID = 20220525041131831;
DELETE FROM CMS_CASH WHERE CMS_COLLATERAL_ID = 20220525020185210;
DELETE FROM CMS_CASH_DEPOSIT WHERE CMS_COLLATERAL_ID = 20220525020185210;
COMMIT;