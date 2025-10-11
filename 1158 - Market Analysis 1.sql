# Write your MySQL query statement below
with cte1 as (
    select distinct buyer_id,
    count(order_id) over(partition by buyer_id) as cnt
    from orders
    where year(order_date)='2019'
)
select users.user_id as buyer_id, users.join_date,
ifnull(cte1.cnt,0) as orders_in_2019
from users left join cte1 
on users.user_id = cte1.buyer_id
