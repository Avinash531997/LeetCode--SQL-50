WITH cte1 AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY product_id ORDER BY year) AS rk
    FROM sales
)
SELECT product_id, year as first_year, quantity, price
FROM cte1 where rk=1;
