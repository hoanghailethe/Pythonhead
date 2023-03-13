-- public void sendEmail(IApprovalFolder approvalFolder) {
--         if (approvalFolder != null && approvalFolder.getId() > 0) {
--             Locale locale = new Locale(PropertyManager.getValue("system.default.language", "en"));
--             List<Object[]> notifyDetailList =
--                     approvalFolderBO.getFpStatusUpdateByFolderForNotification(approvalFolder.getId());

-- CAR/23/9002/00862/05421158

        <return-scalar column="recipient_email" type="string" />
        <return-scalar column="recipient_name" type="string" />
        <return-scalar column="ca_number" type="string" />
        <return-scalar column="customer_name" type="string" />
        <return-scalar column="cif_number" type="string" />
        <return-scalar column="status" type="string" />
        <![CDATA[
            SELECT UNIQUE (CASE
                       WHEN (st.next_owner_id IS NOT NULL)
                       THEN
                          (SELECT su.email
                             FROM sml_user su
                            WHERE su.id = st.next_owner_id)
                       ELSE
                          (SELECT su.email
                             FROM sml_user su
                            WHERE su.id = st.originator_id)
                    END) recipient_email,
                   (CASE
                       WHEN (st.next_owner_id IS NOT NULL)
                       THEN
                          (SELECT su.full_name
                             FROM sml_user su
                            WHERE su.id = st.next_owner_id)
                       ELSE
                          (SELECT su.full_name
                             FROM sml_user su
                            WHERE su.id = st.originator_id)
                    END) recipient_name,
                   ca.ca_number,
                   (SELECT sc.customer_name
                      FROM sml_customer sc
                     WHERE sc.id = ca.borrower_id)
                      customer_name,
                   (SELECT sc.cif_number
                      FROM sml_customer sc
                     WHERE sc.id = ca.borrower_id)
                      cif_number,
                   ca.status
              FROM sml_ca ca
                   INNER JOIN sml_fp_folder_details sffd
                      ON sffd.fp_id = ca.id
                   INNER JOIN sml_trx st
                      ON sffd.fp_folder_id = st.stage_ref_id
             WHERE sffd.fp_folder_id = :folder_id

SELECT * FROM SML_CA WHERE ca_number = 'CAR/23/9002/00862/05421158' ;
SELECT * FROM sml_fp_folder_details WHERE fp_id = (SELECT ID FROM SML_CA WHERE ca_number = 'CAR/23/9002/00862/05421158') ;
SELECT * FROM sml_trx st INNER JOIN sml_fp_folder_details sffd ON sffd.fp_folder_id = st.stage_ref_id WHERE
    sffd.fp_folder_id = (SELECT ID FROM SML_CA WHERE ca_number = 'CAR/23/9002/00862/05421158') ; 

SELECT UNIQUE (CASE
    WHEN (st.next_owner_id IS NOT NULL)
    THEN
        (SELECT su.email
            FROM sml_user su
        WHERE su.id = st.next_owner_id)
    ELSE
        (SELECT su.email
            FROM sml_user su
        WHERE su.id = st.originator_id)
END) recipient_email,
(CASE
    WHEN (st.next_owner_id IS NOT NULL)
    THEN
        (SELECT su.full_name
            FROM sml_user su
        WHERE su.id = st.next_owner_id)
    ELSE
        (SELECT su.full_name
            FROM sml_user su
        WHERE su.id = st.originator_id)
END) recipient_name,
ca.ca_number,
(SELECT sc.customer_name
    FROM sml_customer sc
    WHERE sc.id = ca.borrower_id)
    customer_name,
(SELECT sc.cif_number
    FROM sml_customer sc
    WHERE sc.id = ca.borrower_id)
    cif_number,
ca.status
FROM sml_ca ca
INNER JOIN sml_fp_folder_details sffd
    ON sffd.fp_id = ca.id
INNER JOIN sml_trx st
    ON sffd.fp_folder_id = st.stage_ref_id
WHERE sffd.fp_folder_id = (SELECT ID FROM SML_CA WHERE ca_number = 'CAR/23/9002/00862/05421158') ;

--send to q