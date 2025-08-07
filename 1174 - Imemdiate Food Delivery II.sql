# Write your MySQL query statement below
with cte1 as 
(
    select delivery_id, customer_id, customer_pref_delivery_date, order_date,min(order_date) 
    over (partition by customer_id) as min_order_date
    from delivery
),
cte11 as
(
    select * from cte1
    where order_date=min_order_date
),
cte2 as (
    select 
    SUM(CASE WHEN order_date=customer_pref_delivery_date then 1 else 0 end) as immediate,
    count(distinct customer_id) as total
    from cte11
)
select ROUND(immediate*100/total,2) as immediate_percentage from cte2
