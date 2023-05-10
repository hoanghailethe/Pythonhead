SELECT *
FROM CMS_CHECKLIST
WHERE checklist_id = 20190412017757650;
SELECT *
FROM CMS_CHECKLIST_ITEM
WHERE checklist_id = 20190412017757650;
SELECT *
FROM cms_cust_doc_item di
    JOIN cms_checklist_item ci ON ci.DOC_ITEM_REF = di.CHECKLIST_ITEM_REF_ID
WHERE ci.checklist_id = 20190412017757650;
SELECT *
FROM STAGE_CHECKLIST_ITEM
WHERE checklist_id = 20190412017757650;
SELECT *
FROM cms_stage_cust_doc_item di
    JOIN STAGE_CHECKLIST_ITEM ci ON ci.DOC_ITEM_REF = di.CHECKLIST_ITEM_REF_ID
WHERE ci.checklist_id = 20190412017757650;
SELECT chk.*,
    itm.*,
    cust_itm.*
FROM CMS_CHECKLIST chk,
    CMS_CHECKLIST_ITEM itm
    LEFT OUTER JOIN CMS_CUST_DOC_ITEM cust_itm ON cust_itm.CHECKLIST_ITEM_REF_ID = itm.DOC_ITEM_REF
WHERE chk.CHECKLIST_ID = itm.CHECKLIST_ID
    AND (
        cust_itm.CHECKLIST_ITEM_REF_ID IS NULL
        OR cust_itm.STATUS = 'DELETED'
    )
    AND itm.IN_VAULT = 'Y'
    AND itm.CPC_CUST_STATUS is not null
    AND chk.checklist_id IN(20140523000012596, 20190412017757650);
    
select *
from transaction
where transaction_type = 'COL'
    and reference_id in (
        select cms_collateral_id
        from cms_security
        where security_no = 'PT201912030014921424'
    );

select *
from trans_history
where transaction_id in (
        select transaction_id
        from transaction
        where transaction_type = 'COL'
            and reference_id in (
                select cms_collateral_id
                from cms_security
                where security_no = 'PT201912030014921424'
            )
    );
select max(transaction_id)
from transaction trx,
    cms_stage_cust_doc cust
where trx.transaction_type = 'CUSTODIAN'
    and trx.status <> 'CLOSED'
    and trx.staging_reference_id = cust.CUSTODIAN_DOC_ID
    and cust.checklist_id = 20140523000012596;


    -- CHANGE COL STATUS
    buf.append("SELECT trx.from_state, sec.collateral_status col_status, sec.to_be_discharged_ind, ");
		buf.append("trx.status, trx.reference_id, m.is_stp_ready, stp_trx.status stp_status ");
		buf.append("FROM cms_security sec, transaction trx LEFT OUTER JOIN cms_stp_ready_status_map m ");
		buf.append("ON trx.transaction_id = m.transaction_id ");
		buf.append("LEFT OUTER JOIN stp_master_trans stp_trx ");
		buf.append("ON trx.transaction_id = stp_trx.transaction_id ");
		buf.append("WHERE trx.reference_id = sec.cms_collateral_id ");
		buf.append("AND sec.cms_collateral_id ");