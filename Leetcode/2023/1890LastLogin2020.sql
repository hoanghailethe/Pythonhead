# Write your MySQL query statement below
SELECT user_id,
time_stamp as last_stamp          
 FROM (
    SELECT 
    user_id , time_stamp ,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY time_stamp DESC ) as rn        
    FROM Logins 
    WHERE time_stamp like '2020%'
) as tempt

WHERE rn = 1;
