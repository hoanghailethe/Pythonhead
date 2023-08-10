
## USING WINDOW
SELECT person_name 
FROM(
    SELECT 
        turn,
        person_name, 
        SUM(weight)OVER(ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)as weight_total

        FROM Queue  

        ORDER BY  turn 
        -- WINDOW W AS (ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )

) t
WHERE weight_total <= 1000
ORDER BY weight_total DESC
LIMIT 1 ;


##not WINDOW
SELECT person_name
FROM (
    SELECT 
        q1.person_name,
        q1.weight ,
        SUM(q2.weight) as weight_total 

        FROM QUEUE q1 JOIN QUEUE q2 
            ON q2.turn <= q1.turn

        GROUP BY q1.person_id
        ORDER BY q1.turn 
)t
WHERE weight_total <= 1000
ORDER BY weight_total DESC
LIMIT 1 ;

Runtime
Details
2480ms
Beats 36.32%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL

WITH CTE AS (
    SELECT 
        turn, person_name, weight,
        SUM(weight) OVER(ORDER BY turn ASC) AS tot_weight 
    FROM Queue
    ORDER BY turn
)
SELECT person_name
FROM Queue q
WHERE q.turn = (SELECT MAX(turn) FROM CTE WHERE tot_weight <= 1000);