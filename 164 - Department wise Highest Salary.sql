# Write your MySQL query statement below
with cte1 as (
    select employee.*,department.name as dept_name
    from employee inner join department
    on employee.departmentId=department.Id
),
cte2 as (
    select cte1.*, 
    dense_rank() over(partition by dept_name order by salary desc) as rnk 
    from cte1
    )
select dept_name as Department, name as employee, salary as Salary 
from cte2
where rnk=1
