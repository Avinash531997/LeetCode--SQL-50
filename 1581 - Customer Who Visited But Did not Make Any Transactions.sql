WITH transaction_with_visit as (
    SELECT visit_id from Transactions
)
SELECT DISTINCT customer_id,
COUNT(customer_id) OVER(PARTITION BY customer_id) as count_no_trans
FROM Visits
WHERE Visits.visit_id 
NOT IN (
    SELECT visit_id from transaction_with_visit
)
