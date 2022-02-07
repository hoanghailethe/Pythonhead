-- Runtime: 491 ms, faster than 41.86% of MySQL ; 100% memory
SELECT res1.Customer AS Customers FROM 
    ( SELECT C.name as Customer, O.id AS OrderId
        FROM Customers C 
        LEFT JOIN Orders O 
        ON C.id = O.customerId
        WHERE O.id is null
    ) AS res1