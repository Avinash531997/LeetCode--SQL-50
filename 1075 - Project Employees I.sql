# Write your MySQL query statement below
With cte1 as 
(
    Select p.project_id, p.employee_id, e.name, e.experience_years
    From project p inner join employee e
    on p.employee_id = e.employee_id
),
cte2 as (
select distinct project_id,
AVG(experience_years) over (partition by (project_id)) as average_years
from cte1)
select distinct project_id, ROUND(average_years,2) as average_years 
from cte2
