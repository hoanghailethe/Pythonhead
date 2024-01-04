# Write your MySQL query statement below
SELECT 
    employee_id , department_id 
FROM (
    SELECT 
        employee_id , department_id ,primary_flag,
        ROW_NUMBER()OVER(PARTITION BY employee_id ORDER BY primary_flag DESC) as rn
    FROM Employee 
) t
# WHERE rn = 1
# GROUP BY  employee_id;


# Write your MySQL query statement below
SELECT 
    employee_id , department_id 
FROM (
    SELECT 
        employee_id , department_id ,
        COUNT(*)OVER(PARTITION BY employee_id ORDER BY primary_flag ASC) as cn
    FROM Employee 
) t
WHERE cn = 1 OR department_id ='Y'
GROUP BY  employee_id;

Runtime
Details
1011ms
Beats 85.35%of users with MySQL
Memory
Details
0.00MB
Beats 100.00%of users with MySQL