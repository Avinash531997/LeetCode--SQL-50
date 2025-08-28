# Write your MySQL query statement below
with cte1 as (
    select * from orders
    where order_date  
    between '2020-02-01' and '2020-02-29' 
),
cte2 as (
    select products.product_id, products.product_name,cte1.unit
    from products inner join cte1
    where products.product_id = cte1.product_id
),
cte3 as (
select distinct product_name, sum(unit) 
over(partition by product_id) as unit
from cte2
)
select * from cte3
where unit>=100
