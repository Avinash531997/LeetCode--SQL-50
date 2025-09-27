CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      with cte1 as (
      select id, 
      salary, 
      dense_rank() over(order by salary desc) as rnk
      from employee)
      select distinct salary from cte1
      where rnk=N
  );
END
