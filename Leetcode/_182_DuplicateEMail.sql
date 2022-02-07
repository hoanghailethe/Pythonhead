-- ko dc
SELECT email AS Email
FROM PERSON 
WHERE email =  ( SELECT email, COUNT(id) FROM PERSON WHERE
COUNT(id) > 1 
GROUP BY email)

-- Ko dc
SELECT p.email AS Email
FROM Person p 
WHERE COUNT(p.id) > 1
GROUP BY p.email 


SELECT Email FROM 
			(SELECT p.email as Email, COUNT(email) as ema
			FROM Person p
			GROUP BY p.email) as t1
WHERE t1.ema > 1

-- Runtime: 380 ms, faster than 38.04%
select email as Email 
from person
group by email
having count(email)>1

-- Runtime: 439 ms, faster than 21.72% of MySQ
select DISTINCT(a.email)
from Person a, Person b
where a.id <> b.id
and a.email = b.email
