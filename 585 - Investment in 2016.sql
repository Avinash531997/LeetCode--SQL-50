# Write your MySQL query statement below
with cte1 as (
    select pid,tiv_2015,count(*)
    over(partition by tiv_2015) as ct
    from insurance
 ),
 cte2 as (
 select pid from cte1
 where ct>=2
 ),
 cte3 as (
    select pid,lat,lon, count(*)
    over(partition by lat,lon) as ct
    from insurance
 ),
cte4 as (
    select pid from cte3 
    where ct=1
)
select round(sum(tiv_2016),2) as tiv_2016
from insurance
where pid in (select * from cte2)
and pid in (select * from cte4)
