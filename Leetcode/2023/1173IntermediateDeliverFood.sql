SELECT ROUND( 
    ( 
        SELECT COUNT(*) FROM DELIVERY WHERE order_date = customer_pref_delivery_date  
    ) 
    / COUNT(*) * 100, 2 ) as immediate_percentage
FROM Delivery ;

Runtime
Details
980ms
Beats 44.19%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL