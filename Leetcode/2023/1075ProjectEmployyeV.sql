# Write your MySQL query statement below

    SELECT p.project_id, ROUND(AVG(e.experience_years),2) AS average_years 
    FROM Project p 
    JOIN Employee e
    ON 
    p.employee_id = e.employee_id
    GROUP BY project_id; 

2340ms
Beats 6.65%of users with MySQL
