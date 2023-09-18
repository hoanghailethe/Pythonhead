SELECT 
    # DISTINCT(e.id),
    eu.unique_id     ,
    e.name

FROM Employees e
LEFT  JOIN  EmployeeUNI eu
    ON e.id = eu.id;

-- Runtime
-- Details
-- 3122ms
-- Beats 29.91%of users with MySQL
-- Memory
-- Details
-- 0.00MB
-- Beats 100.00%of users with MySQL