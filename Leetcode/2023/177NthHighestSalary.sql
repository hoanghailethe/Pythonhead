
-- Runtime
-- 1337 ms
-- Beats
-- 5.1%
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN

  RETURN (
    --   # Write your MySQL query statement below.
    SELECT 
        SALARY      
        -- NUMBER_DISTINCT_SALARY AS getNthHighestSalary
    FROM (
        SELECT 
            ROW_NUMBER() OVER (Order by salary DESC ) AS RowNumber,
            -- COUNT(*) AS NUMBER_DISTINCT_SALARY,
            salary
        FROM Employee 
            GROUP BY SALARY 
    ) AS SALARY_ORDER
    WHERE RowNumber = N 
  );
END

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      select max(salary)
      from 
      (select *,
      dense_rank() over (order by salary desc) as dr
      from Employee) s

      where dr = N
      
  );
END
https://nhatkyhoctap.blogspot.com/2019/07/su-dung-rownumber-rank-va-denserank.html

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    # Write your MySQL query statement below.   
    with _tmp as (
        select 
            salary,
            ROW_NUMBER() over(ORDER BY salary DESC) as _row_num
        from (select distinct salary from Employee) x
    )
    select salary
    from _tmp
    where _row_num = N
  );
END

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  SET N=N-1;
  RETURN (
      # Write your MySQL query statement below.
      select distinct (salary) as getNthHighestSalary from Employee
      order by salary desc
      limit 1 OFFSET N
      
  );
END

