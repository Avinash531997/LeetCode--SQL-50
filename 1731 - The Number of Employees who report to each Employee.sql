# Write your MySQL query statement below
with cte1 as (
    select e1.employee_id,e1.name,e1.reports_to,e1.age,e2.name as manager_name
    from (employees e1) inner join (employees e2)
    on e1.reports_to = e2.employee_id
),
cte2 as (
    select distinct reports_to, manager_name,
    count(employee_id) over (partition by (reports_to) order by (reports_to)) as reports_count,
    avg(age) over (partition by (reports_to) order by (reports_to)) as average_age
    from cte1
)
select reports_to as employee_id, manager_name as name, reports_count, ROUND(average_age) as average_age
from cte2 where reports_count>=1
