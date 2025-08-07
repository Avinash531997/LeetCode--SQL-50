WITH cte AS (
    SELECT 
        DATE_FORMAT(trans_date, '%Y-%m') AS month,
        country,
        state,
        amount
    FROM transactions
),
cte_with_windows AS (
    SELECT 
        month,
        country,
        COUNT(*) OVER (PARTITION BY month, country) AS trans_count,
        SUM(amount) OVER (PARTITION BY month, country) AS trans_total_amount,
        SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) OVER (PARTITION BY month, country) AS approved_count,
        SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) OVER (PARTITION BY month, country) AS approved_total_amount
    FROM cte
)
SELECT DISTINCT 
    month, 
    country, 
    trans_count, 
    trans_total_amount, 
    approved_count, 
    approved_total_amount
FROM cte_with_windows;
