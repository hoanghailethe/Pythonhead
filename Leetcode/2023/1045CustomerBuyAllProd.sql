SELECT customer_id
FROM Customer 
GROUP BY customer_id 
HAVING COUNT(DISTINCT PRODUCT_KEY ) = (SELECT COUNT(*) FROM PRODUCT ) ;

Runtime
Details
1118ms
Beats 56.59%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL
