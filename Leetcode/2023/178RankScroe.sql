Runtime
549 ms
Beats
76.52%
# Write your MySQL query statement below
WITH TEMPT AS (
    SELECT 
    SCORE as score
    ,DENSE_RANK() OVER(ORDER BY SCORE DESC) AS ranking
    FROM SCORES
)
SELECT score, ranking as 'rank' FROM TEMPT;

SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank'
FROM Scores