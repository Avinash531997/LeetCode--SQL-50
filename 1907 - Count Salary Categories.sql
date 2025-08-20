# Write your MySQL query statement below
with cte1 as 
(
    select *, 
    case 
        when income < 20000 then "Low Salary"
        when income >= 20000 and income<=50000 then "Average Salary"
        when income > 50000 then "High Salary"
        
    end as category
    from accounts
),
cte2 as (
    select *,
    count(*) over (partition by category ) as accounts_count
    from cte1
),
cte3 as (
    select "Low Salary" as category, 0 as accounts_count
    union 
    select "Average Salary" as category, 0 as accounts_count
    union
    select "High Salary" as category, 0 as accounts_count
),
cte4 as (
select distinct category, accounts_count from cte2 
union select * from cte3)
select distinct category, max(accounts_count) over (partition by category) as accounts_count
from cte4 
