# Write your MySQL query statement below
select distinct user_id, 
COUNT('follower_id') over (partition by (user_id) order by user_id) as followers_count
from followers
