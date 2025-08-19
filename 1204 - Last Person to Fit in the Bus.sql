# Write your MySQL query statement below
with cte1 as (
    select * from queue
    order by turn asc
),
cte2 as (
    select *,sum(weight)
    over(order by turn) as csum
    from cte1
),
cte3 as (
select *, lead(csum) 
over (order by turn) as next_row from cte2
)
select person_name from cte3
where (csum<=1000 and next_row>1000) or (csum<=1000 and next_row is null)
