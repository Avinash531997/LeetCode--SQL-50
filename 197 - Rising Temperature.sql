With subtable as (SELECT id, recordDate, temperature, 
lag(temperature) OVER(ORDER BY recordDate) as lag_temp,
lag(recordDate) OVER(ORDER BY recordDate) as lag_date
FROM Weather)
SELECT DISTINCT id
FROM subtable
WHERE temperature>lag_temp and DATEDIFF(recordDate, lag_date)=1
