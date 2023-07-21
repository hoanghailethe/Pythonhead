SELECT *
FROM (
        SELECT t1.requester_id AS id,
                t1.no_req + t2.no_accept as num
        FROM (
                SELECT ra.requester_id,
                    COUNT(ra.requester_id) as no_req
                FROM RequestAccepted ra
                RIGHT JOIN (
                    SELECT DISTINCT(requester_id) FROM RequestAccepted
                    UNION ALL
                    SELECT DISTINCT( accepter_id ) FROM RequestAccepted
                    ) uni
                ON uni.requester_id = ra.requester_id
                GROUP BY requester_id
            ) t1
            JOIN (
                SELECT ra.accepter_id,
                    COUNT(ra.accepter_id) as no_accept
                FROM RequestAccepted ra
                RIGHT JOIN (
                    SELECT DISTINCT(requester_id) FROM RequestAccepted
                    UNION ALL
                    SELECT DISTINCT( accepter_id ) FROM RequestAccepted
                    ) uni
                ON uni.requester_id = ra.requester_id
                GROUP BY accepter_id
            ) t2 ON t1.requester_id = t2.accepter_id
            
    ) t3
ORDER BY t3.num DESC
LIMIT 1;


Input
RequestAccepted =
| requester_id | accepter_id | accept_date |
| ------------ | ----------- | ----------- |
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |

Use Testcase
Output
| id | num |
| -- | --- |
Expected
| id | num |
| -- | --- |
| 1  | 2   |


# Write your MySQL query statement below

select requester_id as id,
       (select count(*) from RequestAccepted
            where id=requester_id or id=accepter_id) as num
from RequestAccepted
group by requester_id
order by num desc limit 1 ;

| requester_id | accepter_id | accept_date |
| ------------ | ----------- | ----------- |
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 4            | 3           | 2016/06/09  |

Use Testcase
Output
| id | num |
| -- | --- |
| 1  | 2   |
Expected
| id | num |
| -- | --- |
| 3  | 3   |


# Write your MySQL query statement below
# SELECT requester_id AS id, COUNT(*) AS num
# FROM RequestAccepted
# GROUP BY requester_id
# ORDER BY num DESC
# LIMIT 1;

SELECT user_id AS id, COUNT(*) AS num
FROM
(
    SELECT requester_id AS user_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS user_id
    FROM RequestAccepted
) AS all_users
GROUP BY user_id
HAVING num = (
    SELECT COUNT(*) AS max_friends
    FROM
    (
        SELECT requester_id AS user_id
        FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS user_id
        FROM RequestAccepted
    ) AS all_users
    GROUP BY user_id
    ORDER BY max_friends DESC
    LIMIT 1
);