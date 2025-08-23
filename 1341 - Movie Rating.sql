# Write your MySQL query statement below
with cte1 as
(
    select movierating.*,movies.title,users.name
    from movierating inner join movies inner join users
    where movierating.movie_id = movies.movie_id and movierating.user_id = users.user_id
),
cte2 as 
(
    select cte1.*,
    count(movie_id) over(partition by user_id) as movie_ct
    from cte1
    order by movie_ct desc, name asc
),
cte3 as
(
    select title, avg(rating) over(partition by movie_id) as avg_rating
    from cte2 
    where created_at between '2020-02-01' and '2020-02-29'
    order by avg_rating desc, title asc
)
(select name as results 
from cte2
limit 1)
union all 
(select title as results 
from cte3
limit 1)
