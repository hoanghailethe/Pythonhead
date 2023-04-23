-- Imagine you are a student and you gained access to the local government's registration system for school grades. You feel bad for the students with low grades, and you decide to manipulate their grades. You have access to two tables, SCHOOL and STUDENT.
-- First, create a table called TEMP which joins the two tables based on the common column. The result is that TEMP will contain the school name of the students.
-- The next step is to create another table with the name TEMP1, which is based on TEMP, but only contains students that have below average grades in the TEMP table.
-- The last step is to update TEMP1 by setting the grades of the students in that table to the average of the grades of the students in table TEMP
-- The structure of SCHOOL is:
-- SCHOOL_ID INT PRIMARY KEY, SCHOOL_NAME VARCHAR(50)
-- The structure of STUDENT is:
-- STU_ID INT PRIMARY KEY, STU_NAME VARCHAR(50), STU_ADDRESS VARCHAR (50),
-- STU_GRADES INT,
-- STU_SCHOOL INT REFERENCES SCHOOL(SCHOOL_ID)
-- For this test you're using SQL SQLite 3.31.1
-- Feel free to add comments in your code explaining your solution.

CREATE TABLE TEMPT 
    AS SELECT sc.SCHOOL_ID, sc.SCHOOL_NAME, 
                st.STU_ID, st.STU_GRADES, st.STU_NAME
                FROM STUDENT st JOIN SCHOOL sc
                    ON st.STU_SCHOOL = sc.SCHOOL_ID ;

DECLARE @AvarageScore AS FLOAT ;
SELECT @AvarageScore= (SELECT AVG(STU_GRADES) FROM TEMPT) ;


CREATE TABLE TEMPT1 AS SELECT STU_ID, STU_NAME, STU_GRADES FROM TEMPT WHERE STU_GRADES < @AvarageScore ;

UPDATE TEMPT1 SET STU_GRADES =  @AvarageScore ;
COMMIT ;


-- Create TEMP table
CREATE TABLE TEMP AS
SELECT SCHOOL_NAME, STU_GRADES
FROM SCHOOL
JOIN STUDENT ON SCHOOL.SCHOOL_ID = STUDENT.STU_SCHOOL;

-- Create TEMP1 table with below-average grades
CREATE TABLE TEMP1 AS
SELECT SCHOOL_NAME, STU_NAME, STU_ADDRESS, STU_GRADES
FROM TEMP
JOIN STUDENT ON TEMP.STU_GRADES < (SELECT AVG(STU_GRADES) FROM TEMP)
AND TEMP.STU_SCHOOL = STUDENT.STU_SCHOOL;

-- Update grades in TEMP1 to the average grade in TEMP
UPDATE STUDENT
SET STU_GRADES = (SELECT AVG(STU_GRADES) FROM TEMP)
WHERE STU_ID IN (SELECT STU_ID FROM TEMP1);

