WITH cte1 AS (
    SELECT *,
           COUNT(distinct product_key) as total_diff_prod_purchased
           FROM customer
           group by customer_id
)
SELECT customer_id 
FROM cte1 
WHERE total_diff_prod_purchased = (
    SELECT COUNT(DISTINCT product_key)
    FROM product
);
