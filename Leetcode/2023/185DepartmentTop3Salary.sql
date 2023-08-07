SELECT d.name  as Department, e.name as Employee, e.salary as Salary 
FROM Employee e     
JOIN Department d 
ON e.departmentId = d.id
WHERE 
DENSE_RANK () OVER(PARTITION BY salary ORDER BY salary DESC )  <= 3 ;


# Write your MySQL query statement below
SELECT Department, Employee, Salary   FROM (
    SELECT d.name  as Department, e.name as Employee, e.salary as Salary ,
    DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC )  as r
    -- DENSE_RANK() OVER(PARTITION BY i.LocationID ORDER BY i.Quantity DESC) AS Rank 
    FROM Employee e     
    JOIN Department d 
    ON e.departmentId = d.id
) t
WHERE 
r  <= 3 ;
-- Runtime
-- Details
-- 1622ms
-- Beats 92.73%of users with MySQL
-- Memory
-- Details
-- -mb
-- Beats 100.00%of users with MySQL
