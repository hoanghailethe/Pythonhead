SELECT
    s1.*
    UNION ALL
    s2.*
FROM STADIUM s1 
LEFT JOIN STADIUM s2 
    on s1.id = s2.id-1
LEFT JOIN STADIUM s3 
    on s2.id = s3.id-1
WHERE s1.people       >= 100 AND  s2.people       >= 100 AND  s3.people       >= 100 
GROUP BY id ;

# Write your MySQL query statement below
SELECT
    s1.*
FROM STADIUM s1 
LEFT JOIN STADIUM s2 
    on s1.id = s2.id-1
LEFT JOIN STADIUM s3 
    on s2.id = s3.id-1
WHERE s1.people       >= 100 AND  s2.people       >= 100 AND  s3.people       >= 100 ;


-- RES 
SELECT DISTINCT t1.*
FROM Stadium t1, Stadium t2, Stadium t3
WHERE t1.people >= 100 AND t2.people >= 100 AND t3.people >= 100
  AND (
    (t1.id - t2.id = 1 AND t1.id - t3.id = 2 AND t2.id - t3.id = 1) OR
    (t2.id - t1.id = 1 AND t2.id - t3.id = 2 AND t1.id - t3.id = 1) OR
    (t3.id - t2.id = 1 AND t2.id - t1.id = 1 AND t3.id - t1.id = 2)
  )
ORDER BY t1.visit_date;
