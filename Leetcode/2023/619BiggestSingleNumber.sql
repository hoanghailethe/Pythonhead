# Write your MySQL query statement below
SELECT IF (cn = 1, n.num, null) AS NUM
FROM MyNumbers n
    LEFT JOIN (
        SELECT num,
            COUNT(num) AS cn
        FROM MyNumbers
        GROUP BY num
        HAVING COUNT(num) <= 1
        ORDER BY COUNT(num),
            NUM DESC
        LIMIT 1
    ) t ON n.num = t.num
ORDER BY t.cn DESC
LIMIT 1;
-- 725ms
-- Beats 93.67%of users with MySQL
-- Memory
-- Details
-- -mb
-- Beats 100.00%of users with MySQL

SELECT MAX(s1.num) AS num
FROM (SELECT num FROM MyNumbers
GROUP BY 1
HAVING Count(num)=1) AS s1;