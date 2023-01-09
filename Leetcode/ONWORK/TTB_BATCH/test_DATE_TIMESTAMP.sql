ALTER TABLE LOS_FAC ADD INTEGRATION_DATE_6 TIMESTAMP ; 

SELECT SYSDATE FROM DUAl ;

SELECT TRUNC(TO_DATE('27-OCT-92','DD-MON-YY'), 'YEAR') "New Year" FROM DUAL ; 

SELECT TRUNC(SYSDATE) FROM DUAL ;


SELECT * FROM  LOS_FAC WHERE INTEGRATION_DATE_2 IS NOT NULL; -- 15-JUL-19
--ID : 2019111400016870
--20160418014710
--20160418014712
--20160504014766

UPDATE LOS_FAC SET INTEGRATION_DATE_6 = CURRENT_TIMESTAMP WHERE ID = 2019111400016870 ;
commit ;

SELECT CURRENT_TIMESTAMP,SESSIONTIMEZONE FROM DUAL; --09-JAN-23 10.34.30.868000000 AM ASIA/BANGKOK

SELECT INTEGRATION_DATE_6,LOS_FAC.* FROM  LOS_FAC WHERE TRUNC(INTEGRATION_DATE_6) = TRUNC(SYSDATE);  -- WORK

SELECT ID, INTEGRATION_DATE_6 FROM  LOS_FAC WHERE ID = 2019111400016870;-- 15-JUL-19


INSERT INTO TABLE_NAME (TIMESTAMP_VALUE) VALUES (TO_TIMESTAMP('2014-07-02 06:14:00.742000000', 'YYYY-MM-DD HH24:MI:SS.FF'));

UPDATE LOS_FAC SET INTEGRATION_DATE_6 = TO_TIMESTAMP('2023-01-08 11:14:00.742000000', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 20160418014710 ;
UPDATE LOS_FAC SET INTEGRATION_DATE_6 = TO_TIMESTAMP('2023-01-09 00:14:00.742000000', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 20160418014712 ;
UPDATE LOS_FAC SET INTEGRATION_DATE_6 = TO_TIMESTAMP('2023-01-08 09:14:00.742000000', 'YYYY-MM-DD HH24:MI:SS.FF') WHERE ID = 20160504014766 ;
commit ;

--conclude: 
SELECT INTEGRATION_DATE_6,LOS_FAC.* FROM  LOS_FAC WHERE TRUNC(INTEGRATION_DATE_6) = TRUNC(SYSDATE);  -- WORK