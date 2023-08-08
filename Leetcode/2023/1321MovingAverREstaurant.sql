WITH t AS 
(SELECT 
    SUM( amount) as totalEachDay,
    visited_on
FROM CUSTOMER
GROUP BY visited_on   )
SELECT 
    t1.visited_on,
    (t1.totalEachDay + t2.totalEachDay + t3.totalEachDay +t4.totalEachDay +t5.totalEachDay +t6.totalEachDay +t7.totalEachDay ) as amount,
    ROUND((t1.totalEachDay + t2.totalEachDay + t3.totalEachDay +t4.totalEachDay +t5.totalEachDay +t6.totalEachDay +t7.totalEachDay )/7, 2)
    as average_amount 

FROM t t1, t t2, t t3, t t4, t t5  , t t6, t t7
WHERE
    t1.visited_on-1 = t2.visited_on
    and t2.visited_on-1 = t3.visited_on
    and t3.visited_on-1 = t4.visited_on
    and t4.visited_on-1 = t5.visited_on
    and t5.visited_on-1 = t6.visited_on
    and t6.visited_on-1 = t7.visited_on;

Customer =
| customer_id | name     | visited_on | amount |
| ----------- | -------- | ---------- | ------ |
| 1           | Jhon     | 2019-01-04 | 70     |
| 32          | Newton   | 2019-01-05 | 90     |
| 45          | Victoria | 2019-01-06 | 80     |
| 46          | Selena   | 2019-01-06 | 180    |
| 8           | Rose     | 2019-01-07 | 80     |
| 44          | Ashley   | 2019-01-08 | 90     |
| 9           | Daniel   | 2019-01-09 | 190    |
| 35          | Luis     | 2019-01-10 | 60     |
| 14          | Stella   | 2019-01-11 | 80     |
| 25          | Roger    | 2019-01-11 | 150    |
| 10          | Nami     | 2019-01-11 | 160    |
| 17          | James    | 2019-01-11 | 70     |
| 15          | Marti    | 2019-01-12 | 180    |
| 38          | Moustafa | 2019-01-12 | 190    |
| 37          | Zeus     | 2019-01-13 | 200    |
| 6           | Jaze     | 2019-01-14 | 190    |
| 36          | Jonathan | 2019-01-15 | 80     |
| 2           | Jade     | 2019-01-15 | 110    |
| 22          | Leetcode | 2019-01-16 | 170    |
| 27          | Sakura   | 2019-01-16 | 160    |
| 28          | Prudence | 2019-01-17 | 100    |
| 36          | Jonathan | 2019-01-18 | 120    |
| 3           | Maria    | 2019-01-18 | 200    |
| 45          | Victoria | 2019-01-19 | 160    |
| 38          | Moustafa | 2019-01-19 | 140    |
| 35          | Luis     | 2019-01-20 | 60     |
| 31          | Albert   | 2019-01-20 | 160    |
| 17          | James    | 2019-01-21 | 170    |
| 9           | Daniel   | 2019-01-22 | 200    |
| 24          | Ace      | 2019-01-23 | 50     |
| 10          | Nami     | 2019-01-23 | 130    |
| 38          | Moustafa | 2019-01-24 | 140    |
| 1           | Jhon     | 2019-01-25 | 190    |
| 6           | Jaze     | 2019-01-26 | 130    |
| 40          | Drake    | 2019-01-27 | 80     |
| 18          | Jessie   | 2019-01-28 | 160    |
| 11          | Luffy    | 2019-01-28 | 80     |
| 37          | Zeus     | 2019-01-28 | 90     |
| 8           | Rose     | 2019-01-29 | 110    |
| 2           | Jade     | 2019-01-30 | 150    |
| 42          | Carly    | 2019-01-31 | 50     |
| 3           | Maria    | 2019-02-01 | 90     |
| 6           | Jaze     | 2019-02-02 | 60     |
| 4           | Winston  | 2019-02-02 | 90     |
View less 
Output
| visited_on | amount | average_amount |
| ---------- | ------ | -------------- |
| 2019-01-10 | 840    | 120            |
| 2019-01-11 | 1230   | 175.71         |
| 2019-01-12 | 1510   | 215.71         |
| 2019-01-13 | 1450   | 207.14         |
| 2019-01-14 | 1560   | 222.86         |
| 2019-01-15 | 1660   | 237.14         |
| 2019-01-16 | 1800   | 257.14         |
| 2019-01-17 | 1840   | 262.86         |
| 2019-01-18 | 1700   | 242.86         |
| 2019-01-19 | 1630   | 232.86         |
| 2019-01-20 | 1650   | 235.71         |
| 2019-01-21 | 1630   | 232.86         |
| 2019-01-22 | 1640   | 234.29         |
| 2019-01-23 | 1490   | 212.86         |
| 2019-01-24 | 1530   | 218.57         |
| 2019-01-25 | 1400   | 200            |
| 2019-01-26 | 1230   | 175.71         |
| 2019-01-27 | 1090   | 155.71         |
| 2019-01-28 | 1250   | 178.57         |
| 2019-01-29 | 1160   | 165.71         |
| 2019-01-30 | 1130   | 161.43         |
| 2019-01-31 | 1040   | 148.57         |
Expected
| visited_on | amount | average_amount |
| ---------- | ------ | -------------- |
| 2019-01-10 | 840    | 120            |
| 2019-01-11 | 1230   | 175.71         |
| 2019-01-12 | 1510   | 215.71         |
| 2019-01-13 | 1450   | 207.14         |
| 2019-01-14 | 1560   | 222.86         |
| 2019-01-15 | 1660   | 237.14         |
| 2019-01-16 | 1800   | 257.14         |
| 2019-01-17 | 1840   | 262.86         |
| 2019-01-18 | 1700   | 242.86         |
| 2019-01-19 | 1630   | 232.86         |
| 2019-01-20 | 1650   | 235.71         |
| 2019-01-21 | 1630   | 232.86         |
| 2019-01-22 | 1640   | 234.29         |
| 2019-01-23 | 1490   | 212.86         |
| 2019-01-24 | 1530   | 218.57         |
| 2019-01-25 | 1400   | 200            |
| 2019-01-26 | 1230   | 175.71         |
| 2019-01-27 | 1090   | 155.71         |
| 2019-01-28 | 1250   | 178.57         |
| 2019-01-29 | 1160   | 165.71         |
| 2019-01-30 | 1130   | 161.43         |
| 2019-01-31 | 1040   | 148.57         |
| 2019-02-01 | 940    | 134.29         |

# Write your MySQL query statement below
SELECT DISTINCT customer.visited_on, sum(c.amount) amount,                  ROUND(SUM(c.amount) / 7, 2) average_amount FROM customer
JOIN customer c ON c.visited_on BETWEEN                                 DATE_SUB(customer.visited_on, interval 6 day) AND customer.visited_on
WHERE customer.visited_on >= DATE_ADD((SELECT MIN(visited_on) FROM customer),
interval 6 day)
GROUP BY customer.visited_on, customer.customer_id
ORDER BY customer.visited_on;


WITH CTE AS (
  SELECT 
visited_on, COUNT(visited_on) OVER W as day_cnt,
SUM(SUM(amount)) OVER W AS amount, 
ROUND(AVG(sum(amount)) OVER W,2) AS average_amount
FROM customer
GROUP BY 1
WINDOW W AS (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING and CURRENT ROW)
)
SELECT visited_on, amount, average_amount from cte
WHERE day_cnt = 7; 


SELECT
    visited_on,
    SUM(SUM(amount)) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as amount,
    ROUND(AVG(SUM(amount*1.0)) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) as average_amount

FROM Customer

GROUP BY visited_on

ORDER BY visited_on

OFFSET 6 ROWS

