(
    SELECT
        u.name as results
    FROM
        USERs u
        JOIN MOVIERATING r ON u.user_id = r.user_id
    GROUP BY
        r.user_id
    ORDER BY
        COUNT(r.rating) DESC,
        u.name
    LIMIT
        1
)
UNION
ALL (
    SELECT
        m.title as results
    FROM
        MOVIES m
        JOIN MOVIERATING r 
        ON m.movie_id = r.movie_id 
        AND YEAR(r.created_at)= 2020
        AND MONTH(r.created_at) =2 
    GROUP BY
        m.movie_id
    ORDER BY
        AVG(r.rating) DESC,
        m.title ASC
    LIMIT
        1
)