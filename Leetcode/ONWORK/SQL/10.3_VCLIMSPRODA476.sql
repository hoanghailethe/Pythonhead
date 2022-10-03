SELECT * FROM CMS_CHECKLIST WHERE checklist_id = 20190412017757650 ;
SELECT * FROM CMS_CHECKLIST_ITEM WHERE checklist_id = 20190412017757650; 

SELECT * FROM cms_cust_doc_item di   
JOIN cms_checklist_item ci  
ON ci.DOC_ITEM_REF = di.CHECKLIST_ITEM_REF_ID
WHERE ci.checklist_id = 20190412017757650;

SELECT * FROM STAGE_CHECKLIST_ITEM WHERE checklist_id = 20190412017757650; 

SELECT * FROM cms_stage_cust_doc_item di   
JOIN STAGE_CHECKLIST_ITEM ci  
ON ci.DOC_ITEM_REF = di.CHECKLIST_ITEM_REF_ID
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
    AND chk.checklist_id IN(20140523000012596, 20190412017757650)  ;