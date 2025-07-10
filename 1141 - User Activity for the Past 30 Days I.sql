# Write your MySQL query statement below
with cte2 as (
    select activity_date, user_id from activity
    where activity_date 
    between DATE_SUB('2019-07-27', interval 29 DAY) and '2019-07-27'
),
cte3 as (
select activity_date as day,
count(distinct user_id) as active_users
from cte2
group by activity_date
)
select * from cte3 
order by day

