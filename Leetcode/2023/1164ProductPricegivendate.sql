# Write your MySQL query statement below
Select
    p.product_id,
    t.change_date,
    IF(t.product_id IS null, '10', p.new_price) as price
from
    (
        SELECT
            DISTINCT product_id
        FROM
            Products
    ) p
    LEFT JOIN (
        Select
            product_id,
            MAX(change_date) as change_date
        from
            Products
        WHERE
            change_date <= '2019-08-16'
        GROUP By
            product_id
    ) t ON p.product_id = t.product_id;

WITH TEMPt AS(
    Select
        product_id,
        MAX(change_date) as change_date
    from
        Products
    WHERE
        change_date <= '2019-08-16'
    GROUP By
        product_id
)
SELECT
    p.product_id,
    p.new_price as price
FROM
    Products p,
    tempt
WHERE
    p.product_id = tempt.product_id
    and p.change_date = tempt.change_date
UNION
ALL
SELECT
    p.product_id,
    10 as price
FROM
    Products p
WHERE
    p.product_id NOT IN (
        select
            product_id
        FROM
            tempt
    )
GROUP BY
    product_id # ORDER BY product_id;
    -- Runtime
    -- Details
    -- 1304ms
    -- Beats 18.84%of users with MySQL
    -- Memory
    -- Details
    -- -mb
    -- Beats 100.00%of users with MySQL
Select
    p.product_id,
    -- p.change_date , 
    IF(t2.product_id IS null, 10, t2.new_price) as price
from
    (
        SELECT
            DISTINCT product_id
        FROM
            Products
    ) p
    LEFT JOIN (
        SELECT
            p.product_id,
            p.change_date,
            p.new_price
        FROM
            PRODUCTs p
            JOIN (
                Select
                    product_id,
                    new_price,
                    MAX(change_date) as change_date
                from
                    Products
                WHERE
                    change_date <= '2019-08-16'
                GROUP By
                    product_id
            ) t ON p.product_id = t.product_id
            AND p.change_date = t.change_date
    ) t2 ON p.product_id = t2.product_id;


    Runtime
Details
1297ms
Beats 19.21%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL

