# Write your MySQL query statement below
with cte1 as 
(
    select * from products
    where change_date <= '2019-08-16'
),
cte2 as (
    select *, dense_rank() over(partition by product_id order by change_date desc) as rk
    from cte1
),
cte3 as (
    select distinct product_id, 10 as new_price 
    from products
)
select product_id, new_price as price from cte2 where rk=1
union
select product_id, new_price as price from cte3 
where product_id not in (
    select product_id from cte2
)
