SELECT
    product_name,
    SUM(o.unit) as unit
FROM
    Products p
    JOIN Orders o ON p.product_id = o.product_id
    AND YEAR(o.order_date) = 2020
    AND MONTH(o.order_date) = 2
GROUP BY
    p.product_id
HAVING
    SUM(o.unit) >= 100;

-- Runtime
-- Details
-- 1538ms
-- Beats 53.04%of users with MySQL
-- Memory
-- Details
-- -mb
-- Beats 100.00%of users with MySQL
SELECT
    product_name,
    unit
FROM
    Products
    JOIN (
        SELECT
            product_id,
            sum(unit) AS 'unit'
        FROM
            Orders
        WHERE
            month(order_date) = 2
            AND year(order_date) = 2020
        GROUP BY
            product_id
        HAVING
            sum(unit) >= 100
    ) T ON Products.product_id = T.product_id