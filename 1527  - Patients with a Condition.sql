# Write your MySQL query statement below
Select * 
from patients
where conditions LIKE 'DIAB1%' or conditions LIKE '% DIAB1%'
