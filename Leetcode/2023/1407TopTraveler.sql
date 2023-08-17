# Write your MySQL query statement below
SELECT    
    u.name,
    IFNULL( SUM(r.distance ), 0 ) as travelled_distance 
FROM Rides r 
RIGHT JOIN Users u
ON r.user_id  = u.id
GROUP BY u.id
ORDER BY SUM(r.distance ) DESC, name  ;

2266ms
Beats 19.60%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users wit