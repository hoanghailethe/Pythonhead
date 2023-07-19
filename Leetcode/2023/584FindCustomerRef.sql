# Write your MySQL query statement below
SELECT c1.name 
FROM Customer c1  
WHERE 
c1.referee_id != 2 or c1.referee_id IS null;

--
Runtime
Details
1168ms
Beats 34.64%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL