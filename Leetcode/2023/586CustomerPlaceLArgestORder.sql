# Write your MySQL query statement below
SELECT customer_number 
FROM (
    SELECT * 
    FROM t1 WHERE (customer_number, sum_orders) IN 
    (
        SELECT customer_number, MAX(sum_orders) FROM 
        (
            SELECT COUNT(1) as sum_orders
            FROM orders 
            GROUP BY customer_number
        ) AS t1
        GROUP BY customer_number
    ) 
)t3

WITH TEMPT AS (
    SELECT customer_number, COUNT(1) as sum_orders
    FROM orders 
    GROUP BY customer_number
)
SELECT customer_number
FROM TEMPT t1
WHERE t1.sum_orders = (
    SELECT MAX(sum_orders) FROM TEMPT
);

Runtime
Details
1160ms
Beats 39.34%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL

-- beter
SELECT customer_number 
FROM orders
GROUP BY customer_number
ORDER BY COUNT(customer_number) DESC 
LIMIT 1;

