# Wherever you are given a range, keep MIN() and MAX() in mind
SELECT Product.product_id, Product.product_name FROM Product 
JOIN Sales 
ON Product.product_id = Sales.product_id 
GROUP BY Sales.product_id 
HAVING MIN(Sales.sale_date) >= "2019-01-01" AND MAX(Sales.sale_date) <= "2019-03-31";


-- 1084. Sales Analysis III
SELECT s.product_id , product_name
FROM Sales s JOIN Product p
ON s.product_id = p.product_id 
GROUP BY s.product_id 
HAVING MIN(s.sale_date) >= "2019-01-01" AND MAX(s.sale_date) <= "2019-03-31";

