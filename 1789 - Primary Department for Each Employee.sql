# Write your MySQL query statement below
with cte1 as (
    select employee_id, department_id, primary_flag,
    count(department_id) over (partition by (employee_id) order by (employee_id)) as dept_count 
    from employee
),
cte2 as (
    select distinct employee_id, department_id from cte1
    where dept_count=1
),
cte3 as (
    select distinct employee_id, department_id from cte1
    where dept_count>1 and primary_flag='Y'
)
select * 
from cte2 union (select * from cte3)
