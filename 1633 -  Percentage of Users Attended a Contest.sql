# Write your MySQL query statement below
With cte1 as (
    select u.user_id, r.contest_id
    from users u
    inner join register r
    on u.user_id=r.user_id),
cte2 as (
    select distinct contest_id,
    COUNT(user_id) over (partition by (contest_id )) as percentage
    from cte1
),
cte3 as (
    select count(user_id) as ucount from users
),
cte4 as (
    select * 
    from cte2,cte3
)
select contest_id, ROUND((percentage/ucount)*100,2) as percentage
from cte4 
order by percentage desc, contest_id asc
