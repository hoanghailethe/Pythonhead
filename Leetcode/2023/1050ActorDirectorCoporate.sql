# Write your MySQL query statement below
SELECT actor_id, director_id FROM 
(
    SELECT actor_id, director_id
    FROM ActorDirector
    GROUP BY actor_id, director_id
    HAVING COUNT(*) >= 3
) t;

Runtime
Details
681ms
Beats 85.92%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL