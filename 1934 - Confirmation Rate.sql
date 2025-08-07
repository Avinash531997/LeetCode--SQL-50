# Write your MySQL query statement below
with cte1 as (
    select t1.user_id, t2.action
    from signups as t1 left join confirmations as t2
    on t1.user_id=t2.user_id
),
cte2 as (
    select *,count(user_id) over (partition by user_id) as tot
    from cte1
),
cte3 as (
    select *, count(user_id) 
    over (partition by user_id) as conf
    from cte2
    where action='confirmed'
),
cte4 as (
select distinct user_id, round(conf/tot,2) as confirmation_rate
from cte3),
cte5 as (
select distinct user_id, 0 as confirmation_rate 
from signups  
where user_id not in 
    (select distinct user_id from cte4)
)
select * from cte4 union 
select * from cte5
