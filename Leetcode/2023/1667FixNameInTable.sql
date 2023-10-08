# Write your MySQL query statement below
SELECT
    user_id,
    CONCAT(UPPER(firstChar), LOWER(restChar)) as name
    -- UPPER(firstChar) + LOWER(restChar) as name
FROM
(
        SELECT
            user_id,
            SUBSTRING(name, 1, 1) as firstChar,
            SUBSTRING(name, 2, LENGTH(name) - 1) as restChar
        FROM
            USERS
) alias

order bY user_id ;


# Write your MySQL query statement below


select user_id ,CONCAT(UPPER(LEFT(NAME,1)),LOWER(RIGHT(NAME,LENGTH(NAME)-1))) AS NAME
from users
group by user_id
order by user_id;