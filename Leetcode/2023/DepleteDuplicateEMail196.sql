DELETE p1
FROM PERSON p1, PERSON p2 
WHERE p1.EMAIL = p2.EMAIL 
AND p1.id > p2.id ;


# Please write a DELETE statement and DO NOT write a SELECT statement.
# Write your MySQL query statement below
delete 
from Person 
where id not in (select id from (select min(id) as id  from Person
 group by email) as t)



#  DELETE FROM Person
# WHERE id NOT IN (
#   SELECT id FROM (
#     SELECT MIN(id) AS id FROM Person GROUP BY email
#   ) AS t
# );



# Write your MySQL query statement below
select e.id,e.email from
(select id,email,rank() over(partition by email order by id) as rnk from Person)e
where e.rnk = 1 order by id; 