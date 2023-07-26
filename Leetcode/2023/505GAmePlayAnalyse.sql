# Write your MySQL query statement below
SELECT 
ROUND(totalRelog / totalUser, 2) as fraction 
,totalRelog,totalUser
FROM (
        SELECT COUNT(DISTINCT(a.player_id)) as totalRelog
        FROM Activity a
            JOIN (
                SELECT player_id,
                    event_date
                FROM Activity
                GROUP BY player_id
                ORDER BY event_date ASC
            ) fl 
            ON a.player_id = fl.player_id
            AND DATEDIFF (a.event_date,fl.event_date ) = 1 
            -- AND a.event_date = fl.event_date + 1
            -- GROUP BY a.player_id
    ) t1,
    (
        SELECT COUNT(DISTINCT(player_id )) as totalUser
        FROM ACTIVITY
    ) t2;

--TEST 
SELECT a.*
        FROM Activity a
            JOIN (
                SELECT player_id,
                    event_date
                FROM Activity
                GROUP BY player_id
                ORDER BY event_date ASC
            ) fl 
            ON a.player_id = fl.player_id
            AND DATEDIFF (a.event_date,fl.event_date ) = 1 
            ORDER by player_id ;

  | player_id | device_id | event_date | games_played |
| --------- | --------- | ---------- | ------------ |
| 4         | 49        | 2019-01-05 | 68           |
| 6         | 191       | 2019-03-08 | 37           |
| 13        | 121       | 2019-01-20 | 75           |
| 27        | 50        | 2019-03-12 | 75           |
| 29        | 1         | 2019-02-14 | 93           |
| 47        | 69        | 2019-02-13 | 93           |
| 55        | 198       | 2019-03-09 | 7            |
| 57        | 126       | 2019-02-17 | 97           |
| 58        | 94        | 2019-03-09 | 6            |
| 72        | 159       | 2019-02-18 | 84           |
| 89        | 117       | 2019-02-27 | 32           |

COMPARE
| player_id | min_date   |
| --------- | ---------- |
| 4         | 2019-01-04 |
| 9         | 2019-01-04 |
| 12        | 2019-01-11 |
| 19        | 2019-01-17 |
| 28        | 2019-01-03 |
| 39        | 2019-01-03 |
| 48        | 2019-01-08 |
| 59        | 2019-01-17 |
| 60        | 2019-01-12 |
| 67        | 2019-01-07 |
| 86        | 2019-01-10 |
| 98        | 2019-01-05 |
-- FROM

select tempt.*
from (select player_id, min(event_date) as min_date from activity group by player_id) as temp
join activity a
on temp.player_id = a.player_id 
WHERE temp.min_date + 1 = a.event_date ORDER BY player_id;

-- ELSE RES
select round(sum(case when temp.min_date + 1 = a.event_date then 1 else 0 end)
/
count(distinct temp.player_id), 2) as fraction
from (select player_id, min(event_date) as min_date from activity group by player_id) as temp
join activity a
on temp.player_id = a.player_id ;