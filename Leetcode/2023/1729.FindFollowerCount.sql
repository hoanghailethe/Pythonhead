# Write your MySQL query statement below
SELECT
    u.user_id ,
    COUNT(DISTINCT f.follower_id  ) as followers_count 
FROM
    Followers u 
    LEFT JOIN Followers f
    ON u.user_id = f.user_id
    GROUP BY u.user_id
    ORDER BY u.user_id ASC ;