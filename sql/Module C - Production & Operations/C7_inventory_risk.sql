--Objective: Identify products where stock_quantity is above the 75th percentile for their category, but units sold in the last 3 years are below the 25th percentile. These are slow-moving, high-inventory risk items. Include the estimated stock value (stock_quantity * cost_price). 

--For each category compute the 75th and 25th percentile
with percentile_per_category as(
select 
category_id,
percentile_cont(0.75) within group(order by stock_quantity) as pc75,
percentile_cont(0.25) within group(order by stock_quantity) as pc25
from products p
group by 1
),


--Quantities of product sold in the last 3 years 
last_3y_sales as(
select 
product_id,
sum(quantity) as quantity_sold
from order_items oi
inner join orders o on oi.order_id = o.order_id
where status not in ('cancelled', 'returned') and order_date >= current_date - interval '3 years'
group by 1
)


select
p.product_name,
c.category_name,
p.stock_quantity,
round(stock_quantity * cost_price,2) as stock_value,
ls.quantity_sold
from products p
left join categories c on p.category_id = c.category_id
left join percentile_per_category ppc on ppc.category_id = p.category_id and p.stock_quantity > ppc.pc75
left join last_3y_sales ls on p.product_id = ls.product_id
where ls.quantity_sold < ppc.pc25

