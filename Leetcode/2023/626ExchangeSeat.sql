# Write your MySQL query statement below
SELECT 
    CASE
        WHEN id = (SELECT COUNT(*) FROM Seat) and id %2 =1 THEN id 
        WHEN id % 2 = 0 then id - 1
        ELSE id + 1
    END AS id ,
    student     
FROM Seat #
ORDER BY id asc;
Runtime
Details
1105ms
Beats 8.20%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL


# Write your MySQL query statement below

select row_number() over() id ,student
from Seat order by if(mod(id,2)=0,id-1,id+1)
