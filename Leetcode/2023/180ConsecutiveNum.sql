# Write your MySQL query statement below445
WITH TEMPT AS (
	SELECT NUM, 
		ROW_NUMBER() OVER( PARTITION BY NUM ) AS rn
	FROM LOGS
) 

SELECT DISTINCT(NUM) as ConsecutiveNums FROM TEMPT WHERE rn >= 3; 


# Write your MySQL query statement below
SELECT distinct 
    i1.num as ConsecutiveNums 
FROM 
    logs i1,
    logs i2,
    logs i3
WHERE 
    i1.id=i2.id+1 AND 
    i2.id=i3.id+1 AND 
    i1.num=i2.num AND 
    i2.num=i3.num ;

    SELECT DISTINCT num as ConsecutiveNums
FROM (
     SELECT id, num, 
    LAG(num) OVER(ORDER BY id) as prev_num,
    LEAD(num) OVER(ORDER BY id) as next_num
    FROM Logs
 ) l
 WHERE l.num = l.prev_num
 AND l.prev_num = l.next_num
 AND l.num = l.next_num;

 

SELECT DISTINCT(t1.NUM) AS ConsecutiveNums 
FROM LOGS t1, LOGS t2, LOGS t3
WHERE t1.num = t2.num
AND t2.num = t3.num 
AND t1.id = t2.id+1 
AND t2.id = t3.id+1 ;
