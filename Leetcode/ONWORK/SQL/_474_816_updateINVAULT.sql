-- CLIMS update CPC Status for InVAULT = NO
SELECT DOC_ITEM_ID FROM CMS_CHECKLIST_ITEM WHERE IN_VAULT = 'N' AND CPC_CUST_STATUS = 'PENDING_LODGE' ;
UPDATE CMS_CHECKLIST_ITEM SET IN_VAULT = 'Y' WHERE DOC_ITEM_ID IN (SELECT DOC_ITEM_ID FROM CMS_CHECKLIST_ITEM WHERE IN_VAULT = 'N' AND CPC_CUST_STATUS = 'PENDING_LODGE') ;
COMMIT;