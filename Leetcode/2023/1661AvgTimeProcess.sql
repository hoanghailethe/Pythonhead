

WITH ProcessTime 
AS 
(SELECT 
    a2.timestamp - a1.timestamp  as duration,
    a2.machine_id , a2.process_id 
    FROM ACTIVITY a1
    JOIN ACTIVITY a2
    ON a1.machine_id =a2.machine_id 
    AND a1.process_id =a2.process_id 
    AND a1.activity_type ='start'
    AND a2.activity_type='end'
)
SELECT 
    p.machine_id,
    ROUND(
            SUM(p.duration) 
                / COUNT(process_id )
        , 3 ) as processing_time 
FROM ProcessTime p 
GROUP BY machine_id;

-- Runtime
-- Details
-- 518ms
-- Beats 40.00%of users with MySQL
-- Memory
-- Details
-- 0.00MB
-- Beats 100.00%of users with MySQL