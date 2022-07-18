+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.

SELECT name FROM Customer 
WHERE referee_id != 2 or referee_id IS NULL ;

Runtime: 397 ms, faster than 95.12% of MySQL online submissions for Find Customer Referee.
Memory Usage: 0B, less than 100.00% of MySQL online submissions for Find Customer Referee
