SELECT 
    name as 'NAME',   
    SUM(t.amount) as 'BALANCE' 
FROM USERs u
    LEFT JOIN TRANSACTIONs t 
    ON u.account      =t.account 
    GROUP BY    t.account   
HAVING SUM(t.amount)> 10000 ;

-- Runtime
-- Details
-- 1535ms
-- Beats 84.41%of users with MySQL
-- Memory
-- Details
-- 0.00MB
-- Beats 100.00%of users with MySQL

-- NEXT: https://leetcode.com/problems/interleaving-string/
