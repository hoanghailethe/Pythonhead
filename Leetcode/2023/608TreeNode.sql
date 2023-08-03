
SELECT id,
CASE 
    WHEN p_id IS NULL THEN 'Root'
    WHEN id NOT IN (SELECT DISTInCT(p_id ) FROM TREE) THEN 'Leaf'
    ELSE 'Inner'
END AS type
 FROM Tree ;



SELECT id,
CASE 
    WHEN p_id IS NULL THEN 'Root'
    WHEN id NOT IN (SELECT DISTInCT(p_id ) FROM TREE WHERE p_id IS NOt NULL) THEN 'Leaf'
    ELSE 'Inner'
END AS type
 FROM Tree ;

963ms
Beats 82.04%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL