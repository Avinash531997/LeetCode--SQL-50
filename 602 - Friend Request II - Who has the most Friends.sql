# Write your MySQL query statement below
with cte1 as (
    select requester_id, accepter_id 
    from requestaccepted
    union all 
    select accepter_id, requester_id 
    from requestaccepted
),
cte2 as (
select *,count(accepter_id) 
over(partition by requester_id) as friends
from cte1 
order by friends desc)
select requester_id as id, friends as num
from cte2 limit 1
