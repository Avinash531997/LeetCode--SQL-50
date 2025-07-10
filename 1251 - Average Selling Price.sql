With inner_join_table as (
    Select pr.product_id as product_id1, pr.start_date,pr.end_date,pr.price, 
    us.product_id as product_id2, us.purchase_date, us.units 
    from prices pr 
    Left Join unitssold us
    on pr.product_id= us.product_id
),
filtered_data as (
select product_id1 as product_id,units, 
price*units as total_amt
from inner_join_table
where (purchase_date is not null)  and (purchase_date>=start_date) and (purchase_date<=end_date)
),
agg as 
(
    select distinct product_id,
    SUM(total_amt) over (partition by product_id ) as total_amount,
    SUM(units) over (partition by product_id) as total_units
    from filtered_data
)
SELECT 
    p.product_id,
    COALESCE(ROUND(COALESCE(a.total_amount, 0) / NULLIF(a.total_units, 0), 2), 0) AS average_price

FROM 
    (SELECT DISTINCT product_id FROM Prices) p
LEFT JOIN agg a ON p.product_id = a.product_id;
