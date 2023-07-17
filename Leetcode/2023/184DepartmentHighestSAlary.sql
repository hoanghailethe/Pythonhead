
WITH EM_MAX_SAL AS (
	SELECT departmentId, name as EMPLOYEE ,SALARY, RANK() OVER(PARTITION BY departmentId ORDER BY SALARY DESC) as Sal_rnk
	FROM EMPLOYEE
)
SELECT d.name as Department , e.Employee , Salary FROM
EM_MAX_SAL e
JOIN DEPARTMENT d 
ON e.departmentId = d.id
AND e.Sal_rnk = 1 ;

# Write your MySQL query statement below

SELECT Department.name AS Department , Employee.name AS Employee , Employee.salary AS Salary
FROM Employee JOIN Department ON Employee.departmentId=Department.id
WHERE (departmentId,Salary) IN
(SELECT departmentId,MAX(salary) FROM Employee GROUP BY departmentId)