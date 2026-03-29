--Objective: Build a scorecard for each active supplier showing: total revenue generated through their products, average product margin, number of active products, weighted average product rating, return rate across their products, and a revenue rank. Flag suppliers where return rate exceeds 15%.

--Revenue and margin(%) by supplier
with suppliers_revenue as(
select
supplier_name,
sum(line_total) as total_revenue,
round(avg(100 * (p.unit_price - p.cost_price) / p.unit_price), 2) as avg_unit_margin_pct
from
suppliers s
inner join products p on s.supplier_id = p.supplier_id
inner join order_items oi on oi.product_id = p.product_id
left join orders o on oi.order_id = o.order_id
where status not in ('cancelled','returned')
group by
1
),

return_rates as(
select

)




