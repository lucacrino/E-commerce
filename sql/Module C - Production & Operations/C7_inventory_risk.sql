--Objective: Identify products where stock_quantity is above the 75th percentile for their category, but units sold in the last 6 months are below the 25th percentile. These are slow-moving, high-inventory risk items. Include the estimated stock value (stock_quantity * cost_price). 

--For each category compute the 75th percentile
with percentile_per_category as(
select 
category_id,
percentile_cont(0.75) within group(order by stock_quantity)
from products p
group by 1
),


