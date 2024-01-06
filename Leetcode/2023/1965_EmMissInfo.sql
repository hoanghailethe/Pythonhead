SELECT 
employee_id
FROM
    Employees
WHERE employee_id NOT IN (
    SELECT s.employee_id 
    FROM Employees e
    JOIN Salaries s
    ON e.employee_id =s.employee_id  
)
UNION ALL
SELECT 
employee_id
FROM
    Salaries
WHERE employee_id NOT IN (
    SELECT s.employee_id 
    FROM Employees e
    JOIN Salaries s
    ON e.employee_id =s.employee_id  
)

ORDER BY employee_id ;

Runtime
Details
1084ms
Beats 79.48%of users with MySQL
Memory
Details
0.00MB
Beats 100.00%of users with MySQL

--2024:not exist
SELECT 
employee_id
FROM
    Employees e
WHERE NOT EXISTS (
    SELECT * FROM Salaries s
    WHERE e.employee_id =s.employee_id  
)
UNION ALL
SELECT employee_id
FROM
    Salaries s
WHERE NOT EXISTS (
    SELECT * 
    FROM Employees e
    WHERE e.employee_id =s.employee_id  
)

ORDER BY employee_id ;

Runtime
Details
960ms
Beats 83.20%of users with MySQL
Memory
Details
0.00MB
Beats 100.00%of users with MySQL