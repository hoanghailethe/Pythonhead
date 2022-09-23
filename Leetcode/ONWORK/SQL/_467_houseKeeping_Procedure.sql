-- COMPARE DATE TIME to a certain moment
https://stackoverflow.com/questions/8544438/select-records-from-now-1-day
https://stackoverflow.com/questions/10643379/how-do-i-query-for-all-dates-greater-than-a-certain-date-in-sql-server

DateTime start1 = DateTime.Parse(txtDate.Text);

select *  
from dbo.March2010 A 
where A.Date >= '2010-04-01'


SELECT * 
FROM dbo.March2010 A
WHERE A.Date >= start1;


SELECT * 
FROM dbo.March2010 A
WHERE A.Date >= '2010-04-01';


SELECT * 
FROM dbo.March2010 A
WHERE A.Date >= CAST('2010-04-01' as Date);


SELECT *  
FROM dbo.March2010 A 
WHERE A.Date >= Convert(datetime, '2010-04-01' )


SELECT * FROM FOO
WHERE MY_DATE_FIELD >= NOW() - INTERVAL 1 DAY


Subtract 1 day from NOW()

...WHERE DATE_FIELD >= DATE_SUB(NOW(), INTERVAL 1 DAY)
Add 1 day from NOW()

...WHERE DATE_FIELD >= DATE_ADD(NOW(), INTERVAL 1 DAY)

-- == PL/SQL ORACLE
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm
-- https://www.techonthenet.com/oracle/procedures.php
-- https://www.oracletutorial.com/plsql-tutorial/plsql-procedure/

-- LOOP THROUGH A RESULT SET
-- https://stackoverflow.com/questions/49635353/how-to-iterate-through-the-result-of-a-plsql-select
-- http://www.java2s.com/Code/Oracle/PL-SQL/Useforlooptoloopthroughresultfromaselectstatement.htm

BEGIN
FOR item IN
(Select table_name,column_name,num_rows  from all_tab_cols
   join all_tables using (table_name)
   where column_name = 'EmployeeId' and num_rows > 0)
LOOP
DBMS_OUTPUT.PUT_LINE
(item.table_name || '    ' || item.column_name ||'    '||item.num_rows);
END LOOP;
END;

BEGIN
  FOR r IN (
    SELECT a 
    FROM table1 
    WHERE b = c)
  LOOP
    FOR s IN (
      SELECT d
      FROM table2
      WHERE d = a)
    LOOP
      NULL;
    END LOOP;
  END LOOP;
END;

DECLARE
  a_array int_list;
  d_array int_list;
BEGIN
  SELECT a
  BULK COLLECT INTO a_array
  FROM   table1
  WHERE  b = c;

  SELECT d
  BULK COLLECT INTO d_array
  FROM   Table2
  WHERE  d MEMBER OF a_array;

  FOR i IN 1 .. d_array.COUNT LOOP
    NULL;
  END LOOP;
END;

loop bassic
-- https://www.oracletutorial.com/plsql-tutorial/plsql-loop/
-- https: / / www.sqlshack.com / sql - server - stored - procedures - for - beginners / https: / / www.sqlshack.com / sql - server - stored - procedures - for - beginners / COPY TABLE https: / / www.w3schools.com / sql / sql_select_into.asp https: / / www.w3schools.com / sql / sql_insert_into_select.asp https: / / stackoverflow.com / questions / 13237623 / copy - data - into - another - table https: / / stackoverflow.com / questions / 1246760 / how - should - i - pass - a - table - name - into - a - stored - proc CREATE PROC spCountAnyTableRows(@PassedTableName as NVarchar(255)) AS -- Counts the number of rows from any non-system Table, *SAFELY*
-- https://stackoverflow.com/questions/22105121/how-to-take-table-name-as-an-input-parameter-to-the-stored-procedure
BEGIN
DECLARE @ActualTableName AS NVarchar(255)
SELECT @ActualTableName = QUOTENAME(TABLE_NAME)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = @PassedTableName
DECLARE @sql AS NVARCHAR(MAX)
SELECT @sql = 'SELECT COUNT(*) FROM ' + @ActualTableName + ';' EXEC(@SQL)
END -- LOOP in PROCEDURE  - IBM

-- https://www.ibm.com/docs/en/db2/11.5?topic = statements-loop-statement-in-sql-procedures 
CREATE PROCEDURE ITERATOR() LANGUAGE SQL BEGIN
DECLARE v_deptno CHAR(3);
DECLARE v_deptname VARCHAR(29);
DECLARE at_end INTEGER DEFAULT 0;
DECLARE not_found CONDITION FOR SQLSTATE '02000';
DECLARE c1 CURSOR FOR
SELECT deptno, deptname
FROM department
ORDER BY deptno;
DECLARE CONTINUE HANDLER FOR not_found
SET at_end = 1;
OPEN c1;
ins_loop: LOOP FETCH c1 INTO v_deptno,
v_deptname;
IF at_end = 1 THEN LEAVE ins_loop;
ELSEIF v_dept = 'D11' THEN ITERATE ins_loop;
END IF;
INSERT INTO department (deptno, deptname)
VALUES ('NEW', v_deptname);
END LOOP;
CLOSE c1;
END 
-- https://www.tutorialspoint.com/plsql/plsql_for_loop.htm 
-- https://www.oracletutorial.com/plsql-tutorial/plsql-for-loop/
DECLARE l_step PLS_INTEGER := 2;
BEGIN FOR l_counter IN 1..5 LOOP dbms_output.put_line (l_counter * l_step);
END LOOP;
END;
https: / / www.oracletutorial.com / plsql - tutorial / plsql - loop / LOOP IF condition THEN EXIT;
END IF;
END LOOP;
-- PROCESS a STRING with COMMA
https://stackoverflow.com/questions/36325831/use-oracle - pl - sql - for - loop - to - iterate - through - comma - delimited - string 
ou could do it easily in pure SQL.there are multiple ways of doing it,
see Split comma delimited string into rows in Oracle 
https: / / lalitkumarb.wordpress.com / 2014 / 12 / 02 / split - comma - delimited - string - into - rows - in - oracle / However,
if you really want to do it in PL / SQL,
then you could do it as: SQL >
set serveroutput on SQL >
DECLARE 2 str VARCHAR2(100) := 'PEBO,PTGC,PTTL,PTOP,PTA';
3 BEGIN 4 FOR i IN 5 (
    SELECT trim(regexp_substr(str, '[^,]+', 1, LEVEL)) l 6
    FROM dual 7 CONNECT BY LEVEL <= regexp_count(str, ',') + 1 8
) 9 LOOP 10 dbms_output.put_line(i.l);
11
END LOOP;
12
END;
13 / PEBO PTGC PTTL PTOP PTA PL / SQL procedure successfully completed.\

-- IS TABLE OF
https: / / docs.oracle.com / cd / A57673_01 / DOC / server / doc / PLS23 / ch4.htm 

-- commit VALUE after or in a loop
-- https://stackoverflow.com/questions/54743742/oracle-commits-in-for-loop
for i in 1 .. arr.count loop
  begin
    insert  into a (...)
    values ( ...);

    if mod(i, 5000) = 0 then
      commit;
    end if;
  end;

  commit;
end loop;

-- PLAN of EXECUTION: 2 procedures process to facility and COLS 

-- CREATE NECCESSARY TABLE CHECK FIRST = > EXPORT REPORT = SATISFY CONDITION LIST = NOT SATISFY CONDITION LIST = COPY SATISFIED COL / FACs = DELTET SATISFIED COLS / FAC -- CREATE TABLES

--STEP 1: CREATE TABLEs TO CHECK
DROP TABLE HOUSEKEEP_VALID_TO_DELETE_FAC;
DROP TABLE HOUSEKEEP_INVALID_TO_DELETE_FAC;
CREATE TABLE HOUSEKEEP_VALID_TO_DELETE_FAC (
    CMS_FAC_MASTER_ID varchar2(50) NOT NULL,
    STATUS varchar2(50) NOT NULL,
    time_closed DATE NOT NULL
);
CREATE TABLE HOUSEKEEP_INVALID_TO_DELETE_FAC (
    CMS_FAC_MASTER_ID varchar2(50) NOT NULL,
    STATUS varchar2(50) NOT NULL,
    REASON_INVALID VARCHAR(10) NOt NULL
);

-- CHECKING PROCEURE = > EXPORT to REPORT TABLE
-- FAC condition : FAC status : 'closed' ; time 'closed'  > 3 years

set serveroutput on
CREATE OR REPLACE PROCEDURE checkingFacCondition (@LIST_ID VARCHAR(4000)) -- LIST ID : String, VAR CHAR / OR Just a table NAME
AS 
BEGIN
DECLARE inPut VARCHAR2(4000) := @LIST_ID;
-- CREATE TWO output TABLE
    FOR facId IN (
        SELECT trim(regexp_substr(inPut, '[^,]+', 1, LEVEL)) l
        FROM dual CONNECT BY LEVEL <= regexp_count(inPut, ',') + 1
    ) LOOP 
        -- CHECK FAC CONDITION HERE : FROM TRANSACTION TABLE
        BEGIN


        END;
        COMMIT; 
    END LOOP;
END ;

-- COL condition : FAC status : 'DELETED' ; time 'closed'  > 3 years
CREATE OR REPLACE PROCEDURE checkingColCondition (@LIST_ID VARCHAR(4000)) -- LIST ID : String, VAR CHAR / OR Just a table NAME
AS 
BEGIN
DECLARE inPut VARCHAR2(4000) := @LIST_ID;
-- CREATE TWO output TABLE
    FOR colId IN (
        SELECT trim(regexp_substr(inPut, '[^,]+', 1, LEVEL)) l
        FROM dual CONNECT BY LEVEL <= regexp_count(inPut, ',') + 1
    ) LOOP 
        -- CHECK COL CONDITION HERE : FROM TRANSACTION TABLE
        BEGIN
            FOR colCondition AS (
                SELECT STATUS, TRANSACTION_DATE as date, reference_id as id
                FROM TRANSACTION 
                WHERE reference_id = colId
                ) 
            DO
                IF ( colCondition.status <> 'DELETED' OR colCondition.status IS NULL OR colCondition.date ) 
                THEN 
                    --not matched condition save to unmatched table
                END IF;

            END FOR;
        END;
        COMMIT; 
    END LOOP;
END ;

-- REPORT TABLE COL: HK_REPORT_COL_VALID_TO_DEL
-- STEP2 COPY TO NEW TABLE STORE
-- https://www.w3schools.com/sql/sql_insert_into_select.asp
CREATE OR REPLACE PROCEDURE copyColAndCheckList 
AS 
BEGIN
    FOR colId IN (
        SELECT CMS_COLLATERAL_ID
        FROM HK_REPORT_COL_VALID_TO_DEL 
        WHERE reference_id = colId
    ) 
    LOOP 
        -- CHECK COL CONDITION HERE : FROM TRANSACTION TABLE
        BEGIN
            -- INSERT INTO TABLE .... b SELECT * FROM .... o WHERE o.CMS_COLLATERAL_ID = colId ;

        END;
        COMMIT; 
    END LOOP;
    DBMS_OUTPUT.put_line ('Procedure Looping is done');
END ;


CREATE OR REPLACE PROCEDURE copyFac
AS 
BEGIN
    FOR colId IN (
        SELECT CMS_COLLATERAL_ID
        FROM HK_REPORT_COL_VALID_TO_DEL 
        WHERE reference_id = colId
    ) LOOP 
        BEGIN
            
        END;
        COMMIT; 
    END LOOP;
END ;

-- STEP3 DELETE FROM ORIGINAL TABLE
CREATE OR REPLACE PROCEDURE deleteColAndCheckList
AS 
BEGIN
    FOR colId IN (
        SELECT CMS_COLLATERAL_ID
        FROM HK_REPORT_COL_VALID_TO_DEL 
    ) LOOP 
        BEGIN
            -- DELETE FROM .... a WHERE a.CMS_COLLATERAL_ID = colId
        END;
        COMMIT; 
    END LOOP;
END ;

CREATE OR REPLACE PROCEDURE delFac
AS 
BEGIN
    FOR colId IN (
        SELECT CMS_COLLATERAL_ID AS id
        FROM HK_REPORT_COL_VALID_TO_DEL 
        WHERE reference_id = colId
    ) LOOP 
        BEGIN
            
        END;
        COMMIT; 
    END LOOP;
END ;
