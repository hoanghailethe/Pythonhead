
SELECT name AS Customers FROM
Customers
WHERE id
NOT IN ( 
    SELECT C.id FROM 
    CUSTOMERS C
    JOIN ORDERS O 
    ON C.id = O.customerId
 )

 Runtime: 532 ms, faster than 52.15% of MySQL online submissions for Customers Who Never Order.
Memory Usage: 0B, less than 100.00% of MySQL online submissions for Customers Who Never Order.

# Write your MySQL query statement below
#select name as Customers
#from Customers a left join Orders b
#on a.id=b.id
#where b.customerId IS NULL

select name as 'Customers'
from customers
where customers.id not in
(
    select customerid from orders
);

Runtime: 422 ms, faster than 86.81% of MySQL online submissions for Customers Who Never Order.
Memory Usage: 0B, less than 100.00% of MySQL online submissions for Customers Who Never Order.