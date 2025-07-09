# Write your MySQL query statement below
Select e.name,b.bonus
From Employee e LEFT JOIN Bonus b
On e.empID = b.empId
Where IFNULL(bonus,0)<1000
