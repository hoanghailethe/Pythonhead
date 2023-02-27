CREATE TABLE LOS_BATCH_GL_DETAIL (
    REC_INDICATOR NVARCHAR2(1) DEFAULT 'D',
    LEDGER NVARCHAR2(30) DEFAULT 'DOMESTIC',
    SOURCE_SYSTEM_CODE NVARCHAR2(3) DEFAULT 'RSL',
    EFFECTIVE_DATE NVARCHAR2(8) DEFAULT TO_CHAR(SYSDATE,'DDMMYYYY'),
    TRANSACTION_DATE NVARCHAR2(8) DEFAULT TO_CHAR(SYSDATE,'DDMMYYYY'),
    EVENT_DESC NVARCHAR2(80) DEFAULT 'RSLCASHBACKSUCCESS',
    ENTITY_CODE NVARCHAR2(2) DEFAULT '01',
    INTERCOMPANY_CODE NVARCHAR2(2) DEFAULT '00',
    OWNER_BRANCH_CODE NVARCHAR2(4) DEFAULT 'H001',
    ENTRY_BRANCH_CODE NVARCHAR2(4) DEFAULT 'H001',
    DESTINATION_BRANCH_CODE NVARCHAR2(4) DEFAULT '0000',
    OWNER_OFFICE_CODE NVARCHAR2(10) DEFAULT '0402400000',
    ENTRY_OFFICE_CODE NVARCHAR2(10) DEFAULT '1500200201',
    DESTINATION_OFFICE_CODE NVARCHAR2(10) DEFAULT '0000000000',
    CUSTOMER_CODE NVARCHAR2(3) DEFAULT '700',
    PRODUCT_CODE NVARCHAR2(240) DEFAULT '',
    CHANNEL_CODE NVARCHAR2(2) DEFAULT '01',
    PROJECT_CODE NVARCHAR2(8) DEFAULT '00000000',
    TAX_CODE NVARCHAR2(2) DEFAULT '00',
    ENTERED_AMOUNT NVARCHAR2(16) DEFAULT '',
    ENTERED_CURRENCY_CODE NVARCHAR2(3) DEFAULT 'THB',
    EXCHANGE_RATE_TYPE NVARCHAR2(30) DEFAULT ' ',
    EXCHANGE_RATE NVARCHAR2(11) DEFAULT ' ',
    EXCHANGE_RATE_DATE NVARCHAR2(8) DEFAULT ' ',
    ACCOUNTED_AMOUNT NVARCHAR2(16) DEFAULT '',
    ACCOUNTED_CURRENCY_CODE NVARCHAR2(3) DEFAULT 'THB',
    JOURNAL_LINE_DESCRIPTION NVARCHAR2(240) DEFAULT ' ',
    TRANSACTION_NO NVARCHAR2(30) DEFAULT '',
    GL_REFERENCE_NUMBER NVARCHAR2(30) DEFAULT ' ',
    CUSTOMER_TYPE NVARCHAR2(10) DEFAULT ' ',
    TAX_NO NVARCHAR2(30) DEFAULT ' ',
    TAX_DATE NVARCHAR2(8) DEFAULT ' ',
    PAYMENT_DATE NVARCHAR2(8) DEFAULT ' ',
    TAX_ID NVARCHAR2(13) DEFAULT ' ',
    TAX_NAME NVARCHAR2(100) DEFAULT ' ',
    TAX_ADDRESS_1 NVARCHAR2(100) DEFAULT ' ',
    TAX_ADDRESS_2 NVARCHAR2(100) DEFAULT ' ',
    TAX_ADDRESS_3 NVARCHAR2(100) DEFAULT ' ',
    RD_PLACE NVARCHAR2(100) DEFAULT ' ',
    RD_TAX_BRANCH NVARCHAR2(5) DEFAULT ' ',
    WHT_TAX_RATE NVARCHAR2(5) DEFAULT ' ',
    WHT_TAX_TYPE NVARCHAR2(2) DEFAULT ' ',
    TAX_BASE NVARCHAR2(16) DEFAULT ' ',
    TAX_AMOUNT NVARCHAR2(16) DEFAULT ' ',
    INCOME_TYPE NVARCHAR2(50) DEFAULT ' ',
    CUSTOMER_ACCOUNT_NO NVARCHAR2(30) DEFAULT ' ',
    DEPOSIT_TD_NUMBER NVARCHAR2(3) DEFAULT ' ',
    CHEQUE_NUMBER_FROM NVARCHAR2(15) DEFAULT ' ',
    CHEQUE_NUMBER_TO NVARCHAR2(15) DEFAULT ' ',
    TOTAL_COUNT_FOR_CHEQUE NVARCHAR2(10) DEFAULT ' ',
    CHEQUE_AMOUNT NVARCHAR2(16) DEFAULT ' ',
    CONTRACT_DATE NVARCHAR2(8) DEFAULT ' ',
    DUE_DATE NVARCHAR2(8) DEFAULT ' ',
    NOSTRO_BANK_ACCOUNT_NUMBER NVARCHAR2(50) DEFAULT ' ',
    NOSTRO_BANK_REFERENCE_NUMBER NVARCHAR2(30) DEFAULT ' ',
    NOSTRO_VALUE_DATE NVARCHAR2(8) DEFAULT ' ',
    NOSTRO_DUE_DATE NVARCHAR2(8) DEFAULT ' ',
    ADDITIONAL_1 NVARCHAR2(30) DEFAULT '',
    ADDITIONAL_2 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_3 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_4 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_5 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_6 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_7 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_8 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_9 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_10 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_11 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_12 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_13 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_14 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_15 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_1 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_1 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_1 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_1 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_1 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_1 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_2 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_2 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_2 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_2 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_2 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_2 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_3 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_3 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_3 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_3 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_3 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_3 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_4 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_4 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_4 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_4 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_4 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_4 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_5 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_5 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_5 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_5 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_5 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_5 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_6 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_6 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_6 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_6 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_6 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_6 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_7 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_7 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_7 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_7 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_7 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_7 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_8 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_8 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_8 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_8 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_8 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_8 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_9 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_9 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_9 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_9 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_9 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_9 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_10 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ENTERED_AMT_CURR_CODE_10 NVARCHAR2(3) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_TYPE_10 NVARCHAR2(30) DEFAULT ' ',
    ADDITIONAL_ENTERED_EXCHANGE_RATE_10 NVARCHAR2(11) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_10 NVARCHAR2(16) DEFAULT ' ',
    ADDITIONAL_ACCOUNTED_AMT_CURR_CODE_10 NVARCHAR2(3) DEFAULT ' '
);

INSERT INTO LOS_SYS_DB_VERSION
VALUES (
        'Phase_3_Wave3_32',
        '20230601',
        'DB Patch',
        'on-site team',
        'LOS_BATCH_GL_DETAIL',
        SYSDATE
    );
COMMIT;