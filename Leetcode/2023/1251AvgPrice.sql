SELECT 
    p.product_id  ,
    ROUND(
        SUM( u.units * p.price  ) / SUM(u.units ), 
        2 ) AS average_price    
FROM
 Prices  p JOIN UnitsSold u 
 ON p.product_id    = u.product_id   AND u.purchase_date BETWEEN p.start_date AND p.end_date
 GROUP BY p.product_id    ;


Runtime
Details
2500ms
Beats 5.41%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL

# Write your MySQL query statement below
SELECT Prices.product_id,ROUND(SUM(Prices.price*UnitsSold.units)/SUM(UnitsSold.units),2) as average_price
FROM Prices
JOIN UnitsSold
ON Prices.product_id = UnitsSold.product_id
WHERE UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
GROUP BY Prices.product_id