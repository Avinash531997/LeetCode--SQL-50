# Write your MySQL query statement below
With cte as (
    SELECT distinct manager_id as ex_emp
    from employees 
    where manager_id is not Null and 
    manager_id not in (
        select distinct employee_id from 
        employees
    )
)
select employee_id 
from employees
where salary < 30000 and manager_id in (select * from cte)
order by employee_id
