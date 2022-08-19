-- Table: Activity

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some games.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

-- Write an SQL query to report the first login date for each player.


SELECT player_id , event_date AS first_login
FROM (
    SELECT 
        player_id ,
        event_date,
        row_number() OVER (PARTITION BY player_id ORDER BY event_date ASC) AS rn 
        FROM Activity
) tempt 
WHERE rn = 1

-- Runtime: 567 ms, faster than 61.98% of MySQL online submissions for Game Play Analysis I.
-- Memory Usage: 0B, less than 100.00% of MySQL online submissions for Game Play Analysis I.