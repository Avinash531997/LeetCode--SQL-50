# Write your MySQL query statement below
with cte1 as (
    select *, 
    lead(student) over(order by id) as lead_student,
    lag(student) over(order by id) as lag_student
    from seat
)
select id,
case 
when id%2=0 then lag_student
when id%2!=0 then ifnull(lead_student,student)
end as student
from cte1
