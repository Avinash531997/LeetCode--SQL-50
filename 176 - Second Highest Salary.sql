# Write your MySQL query statement below
with cte1 as 
(
    select *, dense_rank() over(order by salary desc) as rk
    from employee
)
select ifnull(
(select salary 
from cte1
where rk=2
limit 1), null) as SecondHighestSalary
