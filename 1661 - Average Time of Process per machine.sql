WITH cte1 AS (
    SELECT 
        machine_id, 
        process_id, 
        activity_type, 
        timestamp,
        LAG(timestamp) OVER (PARTITION BY machine_id, process_id ORDER BY timestamp) AS prev_time
    FROM Activity
),

cte2 as 
(
Select * from cte1 where activity_type='end'
),
cte3 as 
(Select *, (timestamp-prev_time )as time_diff from cte2),
cte4 as 
(select distinct machine_id,
AVG(time_diff) OVER (PARTITION BY machine_id) as processing_time
from cte3
)
 select machine_id, ROUND(processing_time,3) as processing_time
from cte4
