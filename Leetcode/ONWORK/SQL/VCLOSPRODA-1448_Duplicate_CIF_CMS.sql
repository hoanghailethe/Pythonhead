DECLARE
MAIN_PROFILE_ID NUMBER := 0;
BEGIN

UPDATE SCI_LE_MAIN_PROFILE SET
    UPDATE_STATUS_IND = 'U',
    LMP_LE_ID = (SELECT LSP_LE_ID FROM SCI_LE_SUB_PROFILE WHERE CMS_LE_MAIN_PROFILE_ID = MAIN_PROFILE_ID)
WHERE CMS_LE_MAIN_PROFILE_ID = MAIN_PROFILE_ID;
UPDATE TRANSACTION SET FROM_STATE = 'ND', STATUS = 'ACTIVE', OPSDESC = 'MANUAL_UPDATE' WHERE LEGAL_ID = TO_CHAR(MAIN_PROFILE_ID);

END;