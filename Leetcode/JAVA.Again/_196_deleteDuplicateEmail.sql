-- Runtime: 516 ms, faster than 84.24% of MySQL online submissions for Delete Duplicate Emails.
-- Memory Usage: 0B, less than 100.00% of MySQL online submissions for Delete Duplicate Emails.
DELETE FROM PERSON WHERE ID NOT IN 
    (
    SELECT min_id FROM (
        SELECT MIN(ID) AS min_id FROM PERSON GROUP BY email   
    ) AS min_filtering
)



DELETE FROM PERSON WHERE ID IN
    (SELECT delete_id FROM
        (
            SELECT p2.ID as delete_id
            FROM PERSON p1
            INNER JOIN PERSON p2 
            ON p1.email = p2.email 
            WHERE p2.ID > p1.ID
        ) AS delete_id_filter
     )


-- # Write your MySQL query statement below
-- Runtime: 1024 ms, faster than 15.20% of MySQL online submissions for Delete Duplicate Emails.
-- Memory Usage: 0B, less than 100.00% of MySQL online submissions for Delete Duplicate Emails.
DELETE p1 from Person p1
INNER JOIN Person p2
WHERE p2.id < p1.id
AND p1.email = p2.email;