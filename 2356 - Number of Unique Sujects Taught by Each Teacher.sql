# Write your MySQL query statement below
Select teacher_id, 
COUNT(DISTINCT subject_id) as cnt 
FROM teacher
group by (teacher_id)
