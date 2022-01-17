# Write your MySQL query statement below
-- Runtime: 388 ms, faster than 43.32% of MySQL online submissions for Combine Two Tables.
-- Memory Usage: 0B, less than 100.00% of MySQL online submissions for Combine Two Tables.
SELECT P.firstName, P.lastName, A.city, A.state
FROM Person P
LEFT JOIN Address A
ON P.personId = A.personId

# Write your MySQL query statement below
select firstName, lastName, city, state from Person left join Address on Person.personId = Address.personId;
