SELECT user_id as buyer_id, 
    join_date  ,
    t.orders_in_2019 
FROM Users u
LEFT JOIN (
    SELECT 
        buyer_id,
        SUM(CASE WHEN order_date LIKE '%2019%' THEN 1 ELSE 0  END) as orders_in_2019
    FROM Orders 
    -- WHERE order_date LIKE '%2019%'
    GROUP BY buyer_id 
)t
ON u.user_id= t.buyer_id ;


SELECT u.user_id as buyer_id, u.join_date, count(o.order_id) as 'orders_in_2019'
FROM users u
LEFT JOIN Orders o
ON o.buyer_id=u.user_id AND YEAR(order_date)='2019'
GROUP BY u.user_id;


# Write your MySQL query statement below
SELECT u.user_id AS buyer_id, u.join_date, IFNULL(o.orders_in_2019, 0) AS orders_in_2019
FROM Users u
LEFT JOIN (
  SELECT buyer_id, COUNT(*) AS orders_in_2019
  FROM Orders
  WHERE YEAR(order_date) = 2019
  GROUP BY buyer_id
) o ON u.user_id = o.buyer_id;