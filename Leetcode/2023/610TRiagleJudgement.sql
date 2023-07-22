SELECT x, y, z,
CASE
    WHEN x+y>z AND y+z> x and x+z > y THEN 'Yes'
    ELSE 'No'
END AS triangle
FROM Triangle ;

Runtime
Details
521ms
Beats 77.99%of users with MySQL
Memory
Details
-mb
Beats 100.00%of users with MySQL

