-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | name        | varchar |
-- | continent   | varchar |
-- | area        | int     |
-- | population  | int     |
-- | gdp         | int     |
-- +-------------+---------+
-- name is the primary key column for this table.
-- Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.

SELECT name, continent, area, population, gdp
FROM World
WHERE
area >= 3000000 or population >= 25000000;

--RES: 
Runtime: 325 ms, faster than 50.99% of MySQL online submissions for Big Countries.
Memory Usage: 0B, less than 100.00% of MySQL online submissions for Big Countries.
