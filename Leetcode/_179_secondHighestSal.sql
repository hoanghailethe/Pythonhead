# Write your MySQL query statement below
SELECT
(CASE
    WHEN salary THEN salary
    ELSE null
END) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(Salary) FROM Employee )
ORDER BY salary DESC
LIMIT 1


SELECT
ISNULL(
(SELECT DISTINCT Salary
FROM Employee
ORDER BY Salary DESC
OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY),
NULL) AS SecondHighestSalary


select max(Salary) as SecondHighestSalary from Employee where Salary < (select max(Salary) from Employee);