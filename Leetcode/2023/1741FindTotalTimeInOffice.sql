# Write your MySQL query statement below
SELECT 
    event_day as day , emp_id , 
    SUM(out_time - in_time) as total_time 
FROM Employees 

GROUP BY event_day  , emp_id ;

-- 2356. Number of Unique Subjects
SELECT teacher_id,
    COUNT(DISTINCT subject_id) as cnt
FROM Teacher 
GROUP BY teacher_id ;

-- 1693. Daily Leads and Partner/s
# Write your MySQL query statement below
SELECT date_id, make_name,
    COUNT(DISTINCT lead_id) as unique_leads ,
    COUNT(DISTINCT partner_id) as unique_partners
FROM DailySales 
GROUP BY date_id , make_name;

1057ms
Beats 85.19%of users with MySQL
Memory
Details
0.00MB
Beats 100.00%
