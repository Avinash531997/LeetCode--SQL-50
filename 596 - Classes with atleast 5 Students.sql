# Write your MySQL query statement below
With cte1 as (
    select class,
    COUNT(student) over (partition by (class) order by class) as no_of_student
    from courses
)
select distinct class
from cte1 
where no_of_student >=5
