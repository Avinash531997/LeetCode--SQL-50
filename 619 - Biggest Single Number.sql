# Write your MySQL query statement below
with cte1 as (
    select num,
    COUNT(num) over (partition by (num) order by num) as frequency 
    from mynumbers
),
cte2 as (
select num
from cte1 
where frequency=1
)
select MAX(num) as num from cte2
