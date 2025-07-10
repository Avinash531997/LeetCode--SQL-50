# Write your MySQL query statement below
with cte1 as (
    select  distinct *, (rating/position) as r_to_p
    from queries
),
cte2 as 
(
    select query_name, position, rating, r_to_p,
    AVG(r_to_p) over (partition by (query_name)) as quality,
    COUNT(r_to_p) over (partition by (query_name)) as group_count,
    SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) over(partition by (query_name)) as less_than_three
    from cte1
)
select distinct query_name, ROUND(quality,2) as quality,
Round(((less_than_three*100)/group_count),2) as poor_query_percentage
from cte2
