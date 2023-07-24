# Write your MySQL query statement below
SELECT * 
FROM Cinema c
WHERE MOD(ID, 2 ) != 0 
AND description != 'boring'
ORDER BY rating DESC ;

# Write your MySQL query statement below
SELECT *
FROM Cinema
WHERE id %2 <> 0 AND description != 'boring'
ORDER BY rating DESC


# Write your MySQL query statement below
UPDATE Salary 
set sex =
  CASE sex
    WHEN 'm' THEN 'f'
    ELSE 'm'
  END;
  