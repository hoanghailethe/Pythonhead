Runtime
Details
903ms
Beats 95.90%of users with MySQL
Memory
Details
0.00MB
Beats 100.00%of users with MySQL

# Write your MySQL query statement below
SELECT 
    product_id ,
    'store1' as store,
    store1 as price 
FROM Products p WHERE store1 is not null
UNION ALL
SELECT 
    product_id ,
    'store2' as store,
    store2 as price  
FROM Products p WHERE store2 is not null
UNION ALL
SELECT 
    product_id ,
    'store3' as store,
    store3 as price 
FROM Products p WHERE store3 is not null;