    private static final String SELECT_CA_ID_OWNED_STP_CANDIDATE_QUERY =
            " SELECT id FROM ( SELECT ca.id FROM sml_ca ca "
                    + " WHERE ca.integration_host_5 = ? "
                    + " AND ca.integration_sts_1 = 'I' "
                    + " ORDER BY ca.integration_sts_1 asc) WHERE ROWNUM = 1 ";
//                    + " AND ca.integration_date_1 = "
//                    +          "( "
//                    +             " SELECT Min(ca_x.integration_date_1) "
//                    +             " FROM sml_ca ca_x "
//                    +             " WHERE ca_x.integration_host_5 = ? "
//                    +             " AND ca_x.integration_sts_1 = 'I' "
//                    +           " ) "
//                    + " AND ROWNUM = 1 ";

-- private static final String UPDATE_TO_OWN_STP_CANDIDATE_QUERY =
UPDATE sml_ca stp_candidate
SET stp_candidate.version_time = (stp_candidate.version_time + 1),
      stp_candidate.last_update_date = SYSDATE,
      stp_candidate.integration_host_5 = ?,
      stp_candidate.integration_host_2 = ?
WHERE stp_candidate.id = (@CA_ID_CANDIDATE @);
/ / COMMENT
WHERE stp_candidate.integration_sts_1 = 'I'
      AND stp_candidate.integration_host_5 IS NULL / / Check that no other CA with same customer is WIP for STP
      AND 0 = (
            SELECT COUNT(1)
            FROM sml_ca ca_x
            WHERE ca_x.integration_sts_1 IN ('I', 'Q', 'G')
                  AND ca_x.integration_host_5 IS NOT NULL
                  AND ca_x.borrower_id = stp_candidate.borrower_id
      )
      AND stp_candidate.id = (@CA_ID_CANDIDATE @);
-- private static final String SELECT_CA_ID_STP_CANDIDATE_QUERY =
SELECT ID
FROM (
            SELECT CA.ID
            FROM SML_CA CA
            WHERE CA.INTEGRATION_STS_1 = 'I'
                  AND CA.INTEGRATION_HOST_5 IS NULL
                  AND CA.INTEGRATION_DATE_1 IS NOT NULL -- this is added HUGE CHANGE HERE
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
            ORDER BY CA.INTEGRATION_DATE_1 ASC    -- ADDED this
      )
WHERE ROWNUM = 1;
/ / COMMENT
SELECT ca.id
FROM sml_ca ca
WHERE ca.integration_sts_1 = 'I'
      AND ca.integration_host_5 IS NULL / / Check that no other CA with same customer is WIP for STP
      AND 0 = (
            SELECT COUNT(1)
            FROM sml_ca ca_x
            WHERE ca_x.integration_sts_1 IN ('I', 'Q', 'G')
                  AND ca_x.integration_host_5 IS NOT NULL
                  AND ca_x.borrower_id = ca.borrower_id
      )
      AND (
            (
                  SELECT COUNT(1)
                  FROM sml_facility fac
                  WHERE fac.ca_id = ca.id
            ) + (
                  SELECT COUNT(1)
                  FROM sml_ca_collateral colLink
                  WHERE colLink.existing_ind IN ('Y', 'N')
                        AND colLink.ca_id = ca.id
            )
      ) >= ? / / Min
      AND (
            (
                  SELECT COUNT(1)
                  FROM sml_facility fac
                  WHERE fac.ca_id = ca.id
            ) + (
                  SELECT COUNT(1)
                  FROM sml_ca_collateral colLink
                  WHERE colLink.existing_ind IN ('Y', 'N')
                        AND colLink.ca_id = ca.id
            )
      ) <= ? / / Max
      AND ca.integration_date_1 = (
            SELECT min(ca_x.integration_date_1)
            FROM sml_ca ca_x
            WHERE ca_x.integration_sts_1 = 'I'
                  AND ca_x.integration_host_5 IS NULL
                  AND (
                        (
                              SELECT COUNT(1)
                              FROM sml_facility fac_x
                              WHERE fac_x.ca_id = ca_x.id
                        ) + (
                              SELECT COUNT(1)
                              FROM sml_ca_collateral colLink_x
                              WHERE colLink_x.existing_ind IN ('Y', 'N')
                                    AND colLink_x.ca_id = ca_x.id
                        )
                  ) >= ? / / Min
                  AND (
                        (
                              SELECT COUNT(1)
                              FROM sml_facility fac_x
                              WHERE fac_x.ca_id = ca_x.id
                        ) + (
                              SELECT COUNT(1)
                              FROM sml_ca_collateral colLink_x
                              WHERE colLink_x.existing_ind IN ('Y', 'N')
                                    AND colLink_x.ca_id = ca_x.id
                        )
                  ) <= ? / / Max
      )
      AND ROWNUM = 1;