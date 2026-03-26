--Objective: List the top 20 products by total revenue. For each product, include the category, total units sold, gross margin (unit_price - cost_price), and margin percentage. Which high-revenue products have the lowest margins?
--Note: ~15 rows reference product_ids absent from products


--Create a cte with delivered orders whose product_ids are recorded in products (see Note) + rough measures

with cte1 as(
select 
product_name,
category_name,
p.unit_price,
cost_price,
sum(quantity) as units_sold,
sum(line_total) as total_revenue
from 
order_items oi
inner join orders o on o.order_id = oi.order_id             --These inner joins return the table recording delivered orders whose products exist in products (see Note)
inner join products p on oi.product_id = p.product_id         
left join categories c on p.category_id = c.category_id     --No need to inner join categories as well, all rows in products have a not null category_id
where o.status = 'delivered'
group by 1,2,3,4
)


select
product_name,
category_name,
units_sold,
total_revenue,
unit_price - cost_price as gross_margin,
round(100*(unit_price-cost_price)/unit_price,2) as margin_pct
from cte1
order by 4 desc
limit 20



