# Write your MySQL query statement below
SELECT 
    contest_id,
    ROUND(COUNT(r.user_id)/
   ( SELECT COUNT(user_id) FROM USERs)*100, 2) as percentage

    FROM  Register r
    LEFT JOIN    Users u 
    ON r.user_id     = u.user_id    

    GROUP BY r. contest_id 
    ORDER BY percentage DESC, contest_id ASC ;
Runtime
Details
1941ms
Beats 57.36%of users with MySQL
Memory
Details
0.00MB
Beats 100.00%of users with MySQL

1683. Invalid Tweets

SELECT tweet_id FROM Tweets 
WHERE LENGTH(content) > 15 ;