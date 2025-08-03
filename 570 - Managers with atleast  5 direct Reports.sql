# Write your MySQL query statement below
with cte1 as (
    select distinct managerId,count(id) over (partition by managerId) as cnt
    from employee 
    where managerId is not null
)
select name from cte1,employee
where cte1.managerId=employee.id
and cnt>=5
