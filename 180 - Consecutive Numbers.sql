with cte1 as (
    select *, 
    lag(num,1) over (order by id) as prev1, 
    lag(num,2) over (order by id) as prev2
    from logs
)
select distinct num as ConsecutiveNums from 
cte1 
where 
num=prev1 and num=prev2
