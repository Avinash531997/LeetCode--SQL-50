# Write your MySQL query statement below
with cte1 as (
    select player_id, event_date,
    min(event_date) over(partition by player_id) as min_date
    from activity
),
cte2 as (
    select cte1.*,
    count(distinct player_id) as req_players
    from cte1
    where datediff(event_date,min_date)=1
)
select Round((req_players/ (select count(distinct player_id) from activity)),2) as fraction 
from cte2
