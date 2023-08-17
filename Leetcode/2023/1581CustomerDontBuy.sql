# Write your MySQL query statement below
SELECT
    customer_id,
    COUNT(customer_id) as count_no_trans 
FROM
    (
        SELECT
            customer_id,
            t.amount
        FROM
            Visits v
            LEFT JOIN Transactions t ON v.visit_id = t.visit_id
        WHERE
            t.amount is null
    ) tempt
GROUP BY
    customer_id;

--     Runtime
-- Details
-- 3244ms
-- Beats 33.70%of users with MySQL
-- Memory
-- Details
-- -mb
-- Beats 100.00%of users with MySQL