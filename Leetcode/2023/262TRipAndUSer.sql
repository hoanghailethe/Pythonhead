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
SELECT  t.*
FROM Trips t, 
    (
        SELECT * 
        FROM USER
        WHERE ROLE IN ('client', 'driver') AND BANNED = 'No'
    ) uu
WHERE (t.client_id = uu.users_id 
OR t. driver_id = uu.users_id) 
WHERE request_at  between '2013-10-01' and '2013-10-03'
GROUP BY request_at
SELECT FORMAT( TotalCanceled / totalTrips, '0.00')
FROM (
    (SELECT COUNT(1) FROM trip_unbaned WHERE STATUS != 'complete') AS TotalCanceled,
    (SELECT count(1) as totalTrips from trip_unbaned ) AS totalTrips
);