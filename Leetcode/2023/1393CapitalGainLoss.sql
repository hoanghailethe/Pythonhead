# Write your MySQL query statement below
SELECT
stock_name    ,
SUM(CASE WHEN operation = 'Buy' THEN -price ELSE price END) as capital_gain_loss 
FROM Stocks s
GROUP BY stock_name;

-- Runtime
-- Details
-- 1044ms
-- Beats 66.28%of users with MySQL
-- Memory
-- Details
-- 0.00MB
-- Beats 100.00%of users with MySQL