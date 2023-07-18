SELECT DAY , Cancellation_Rate
FROM (
    SELECT 


)

WITH TEMPT1 AS (
    SELECT * 
    FROM USER
    WHERE ROLE = 'driver' AND BANNED = 'No'
)

WITH unban_u AS (
    SELECT * 
    FROM USER
    WHERE ROLE IN ('client', 'driver') AND BANNED = 'No'
)
SELECT  
    COUNT(*)
FROM Trips t, unban_u uu
WHERE (t.client_id = uu.users_id 
OR t. driver_id = uu.users_id) 
-- AND status != 'complete' 
WHERE request_at  between '2013-10-01' and '2013-10-03'
GROUP BY request_at;  -- canceled 

SELECT  
    COUNT(*)
FROM Trips t, unban_u uu
WHERE (t.client_id = uu.users_id 
OR t. driver_id = uu.users_id) 
-- AND status == 'complete' 
WHERE request_at  between '2013-10-01' and '2013-10-03'
GROUP BY request_at;


WITH trip_unbaned AS
(
    SELECT  t.*
    FROM Trips t, 
        (
            SELECT * 
            FROM Users 
            WHERE ROLE IN ('client', 'driver') AND BANNED = 'No'
        ) uu
    WHERE (t.client_id = uu.users_id 
    OR t. driver_id = uu.users_id) 
    AND request_at  between '2013-10-01' and '2013-10-03'
    GROUP BY request_at
)
SELECT FORMAT( TEMPT1.TotalCanceled / TEMPT1.totalTrips, '0.00') AS CancellationRate
FROM (
        SELECT * FROM 
        (
            (SELECT COUNT(1) FROM trip_unbaned WHERE STATUS != 'complete') AS TotalCanceled,
            (SELECT COUNT(1) as totalTrips from trip_unbaned ) AS totalTrips
        ) 
    ) AS TEMPT1 ;


WITH trip_unbaned AS
(
    SELECT  request_at, status
    FROM Trips t
    WHERE t.client_id NOT IN (SELECT ID FROM Users WHERE ROLE IN ('client', 'driver') AND BANNED = 'Yes') 
    AND t. driver_id NOT IN (SELECT ID FROM Users WHERE ROLE IN ('client', 'driver') AND BANNED = 'Yes')  
    AND request_at  >= '2013-10-01' and request_at  <= '2013-10-03'
)
SELECT 
    t1.request_at as Day, 
    FORMAT( totalCompleted /  totalTrips, '0.00')  AS CancellationRate,
    totalCompleted, totalTrips
FROM 
    (SELECT COUNT(1) as totalTrips, request_at
    FROM trip_unbaned
    GROUP BY request_at 
    ) t1
    JOIN
    (SELECT COUNT(1) as totalCompleted , request_at
    FROM trip_unbaned 
    WHERE STATUS != 'completed' GROUP BY request_at) t2
    ON t1.request_at = t2.request_at ;


    -- QUITE CLOSE
    
   WITH trip_unbaned AS
(
    SELECT  request_at, status
    FROM Trips t
    WHERE t.client_id NOT IN (SELECT ID FROM Users WHERE ROLE IN ('client', 'driver') AND BANNED = 'Yes') 
    AND t. driver_id NOT IN (SELECT ID FROM Users WHERE ROLE IN ('client', 'driver') AND BANNED = 'Yes')  
    AND request_at  >= '2013-10-01' and request_at  <= '2013-10-03'
)
SELECT 
    t1.request_at as Day, 
    FORMAT( totalCompleted /  totalTrips, '2N')  AS CancellationRate,
    totalCompleted, totalTrips
FROM 
    (SELECT COUNT(1) as totalTrips, request_at
    FROM trip_unbaned
    GROUP BY request_at 
    ) t1
    JOIN
    (SELECT COUNT(1) as totalCompleted , request_at
    FROM trip_unbaned 
    WHERE STATUS == 'completed' GROUP BY request_at) t2
    ON t1.request_at = t2.request_at ;


--| Day        | CancellationRate | totalCompleted | totalTrips |
| ---------- | ---------------- | -------------- | ---------- |
| 2013-10-02 | 1.00             | 3              | 3          |
| 2013-10-03 | 0.67             | 2              | 3          |


-- ANSW

select 
    request_at as "Day",
    round(
        (sum(case when status = "cancelled_by_driver" or status = "cancelled_by_client" then 1 else 0 end) / count(status)), 2
    ) as "Cancellation Rate"
from
    Trips
where 
    client_id not in (select users_id from Users where role = 'client' and banned ='Yes') 
and 
    driver_id not in (select users_id from Users where role = 'driver' and banned ='Yes') 
and 
    request_at >= "2013-10-01" and request_at <= "2013-10-03"
group by 
    request_at ;

SELECT Request_at AS Day, ROUND(SUM(IF(Status = 'completed', 0, 1))/COUNT(Status), 2) AS 'Cancellation Rate' 
FROM Trips 
WHERE Client_Id NOT IN (SELECT Users_Id FROM Users WHERE Banned = 'Yes') 
    AND Driver_Id NOT IN (SELECT Users_Id FROM Users WHERE Banned = 'Yes')
    AND Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY Request_at;

SELECT t.request_at AS 'Day', ROUND(SUM(CASE
    WHEN t.status LIKE 'ca%' THEN
    1
    ELSE 0 END)/COUNT(*),2) AS "Cancellation Rate"
FROM Trips t
JOIN Users clients
    ON t.client_id = clients.users_id
        AND clients.banned = 'No'
JOIN Users drivers
    ON t.driver_id = drivers.users_id
        AND drivers.banned = 'No'
WHERE t.request_at
    BETWEEN '2013-10-01'
        AND '2013-10-03'
GROUP BY  t.request_at;


