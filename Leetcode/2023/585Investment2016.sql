# Write your MySQL query statement below
SELECT SUM(tiv_2016 )
FROM Insurance i
WHERE 
pid in 
(SELECT PID FROM INSURANCE GROUP BY lat, lon HAVING COUNT((lat, lon) ) <2)
GROUP BY tiv_2015 ; 

# Write your MySQL query statement below
SELECT SUM(tiv_2016 ) as tiv_2016
FROM Insurance i
WHERE 
pid in 
(SELECT i2.PID FROM INSURANCE i2 GROUP BY lat, lon HAVING COUNT(lat) <2)
GROUP BY tiv_2015 ; 

Insurance =
| pid | tiv_2015 | tiv_2016 | lat  | lon  |
| --- | -------- | -------- | ---- | ---- |
| 1   | 224.17   | 952.73   | 32.4 | 20.2 |
| 2   | 224.17   | 900.66   | 52.4 | 32.7 |
| 3   | 824.61   | 645.13   | 72.4 | 45.2 |
| 4   | 424.32   | 323.66   | 12.4 | 7.7  |
| 5   | 424.32   | 282.9    | 12.4 | 7.7  |
| 6   | 625.05   | 243.53   | 52.5 | 32.8 |...
View all 

Use Testcase
Output
| tiv_2016           |
| ------------------ |
| 1853.3899536132812 |
| 2367.3300170898438 |
| 243.52999877929688 |
| 463.8500061035156  |
Expected
| tiv_2016 |
| -------- |
| 4220.72  |


SELECT ROUND (SUM(t.totalSame),2) as tiv_2016
FROM (
    SELECT tiv_2015, SUM(tiv_2016 ) as totalSame
    FROM Insurance i
    WHERE 
    pid in 
    (SELECT i2.PID FROM INSURANCE i2 GROUP BY lat, lon HAVING COUNT(lat) <2)
    GROUP BY tiv_2015
) t; 

Insurance =
| pid | tiv_2015 | tiv_2016 | lat  | lon  |
| --- | -------- | -------- | ---- | ---- |
| 1   | 224.17   | 952.73   | 32.4 | 20.2 |
| 2   | 224.17   | 900.66   | 52.4 | 32.7 |
| 3   | 824.61   | 645.13   | 72.4 | 45.2 |
| 4   | 424.32   | 323.66   | 12.4 | 7.7  |
| 5   | 424.32   | 282.9    | 12.4 | 7.7  |
| 6   | 625.05   | 243.53   | 52.5 | 32.8 |
| 7   | 424.32   | 968.94   | 72.5 | 45.3 |
| 8   | 624.46   | 714.13   | 12.5 | 7.8  |
| 9   | 425.49   | 463.85   | 32.5 | 20.3 |
| 10  | 624.46   | 776.85   | 12.4 | 7.7  |
| 11  | 624.46   | 692.71   | 72.5 | 45.3 |
| 12  | 225.93   | 933      | 12.5 | 7.8  |
| 13  | 824.61   | 786.86   | 32.6 | 20.3 |
| 14  | 824.61   | 935.34   | 52.6 | 32.8 |
View less 
Output
| tiv_2016 |
| -------- |
| 4928.1   |
Expected
| tiv_2016 |
| -------- |
| 4220.72  |

-- FIX: 
SELECT ROUND (SUM(t.totalSame),2) as tiv_2016
FROM (
    SELECT tiv_2015, SUM(tiv_2016 ) as totalSame
    FROM Insurance i
    WHERE 
    pid in 
    (SELECT i2.PID FROM INSURANCE i2 GROUP BY lat, lon HAVING COUNT(lat) <2)
    GROUP BY tiv_2015
    HAVING COUNT(tiv_2015) > 1
) t; 

| pid | tiv_2015 | tiv_2016 | lat  | lon  |
| --- | -------- | -------- | ---- | ---- |
| 1   | 224.17   | 952.73   | 32.4 | 20.2 |
| 2   | 224.17   | 900.66   | 52.4 | 32.7 |
| 3   | 824.61   | 645.13   | 72.4 | 45.2 |
| 4   | 424.32   | 323.66   | 12.4 | 7.7  |
| 5   | 424.32   | 282.9    | 12.4 | 7.7  |
| 6   | 625.05   | 243.53   | 52.5 | 32.8 |
| 7   | 424.32   | 968.94   | 72.5 | 45.3 |
| 8   | 624.46   | 714.13   | 12.5 | 7.8  |
| 9   | 425.49   | 463.85   | 32.5 | 20.3 |
| 10  | 624.46   | 776.85   | 12.4 | 7.7  |
| 11  | 624.46   | 692.71   | 72.5 | 45.3 |
| 12  | 225.93   | 933      | 12.5 | 7.8  |
| 13  | 824.61   | 786.86   | 32.6 | 20.3 |
| 14  | 824.61   | 935.34   | 52.6 | 32.8 |
| 15  | 826.37   | 516.1    | 12.4 | 7.7  |
| 16  | 824.61   | 374.5    | 12.6 | 7.9  |
| 17  | 824.61   | 924.19   | 32.6 | 20.4 |
| 18  | 626.81   | 897.47   | 52.6 | 32.9 |
| 19  | 224.76   | 714.79   | 72.6 | 45.4 |
| 20  | 224.76   | 681.53   | 12.4 | 7.7  |
| 21  | 427.25   | 263.27   | 32.7 | 20.4 |
| 22  | 224.76   | 671.8    | 52.7 | 32.9 |
| 23  | 424.9    | 769.18   | 72.7 | 45.4 |
| 24  | 227.69   | 830.5    | 12.7 | 7.9  |
| 25  | 424.9    | 844.97   | 12.4 | 7.7  |
| 26  | 424.9    | 733.35   | 52.7 | 32.9 |
| 27  | 828.13   | 931.83   | 72.8 | 45.5 |
| 28  | 625.05   | 659.13   | 12.8 | 8    |
| 29  | 625.05   | 300.16   | 32.8 | 20.5 |
View less 

Use Testcase
Output
| tiv_2016 |
| -------- |
| 6722.23  |
Expected
| tiv_2016 |
| -------- |
| 8206.2   |

SELECT ROUND (SUM(t.totalSame),2) as tiv_2016
FROM (
    SELECT i.tiv_2015, SUM(i.tiv_2016 ) as totalSame
    FROM Insurance i
    WHERE 
    pid in 
    (
        SELECT t1.PID FROM 
            (SELECT i2.PID, i2.lat, i2.lon FROM INSURANCE i2 GROUP BY i2.tiv_2015 HAVING COUNT(i2.tiv_2015) > 1 ) t1
        GROUP BY t1.lat, t1.lon HAVING COUNT(t1.lat) <2
    ) 
    GROUP BY tiv_2015
) t; 

Insurance =
| pid | tiv_2015 | tiv_2016 | lat | lon |
| --- | -------- | -------- | --- | --- |
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
Output
| tiv_2016 |
| -------- |
| 5        |
Expected
| tiv_2016 |
| -------- |
| 45       |