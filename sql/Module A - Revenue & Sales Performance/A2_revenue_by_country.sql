--Objective: total revenue and average order value by country and loyalty tier. Which combination generates the highest revenue per order?

select country, loyalty_tier, round(sum(line_total),2) as total_revenue, count(distinct o.order_id) as total_orders, round(avg(line_total),2) as avg_order_value
from customers c
natural join orders o
left join order_items oi
on o.order_id = oi.order_id
where delivery_date is not null  
group by 1,2
order by 1, array_position(array['platinum','gold','silver','bronze'],loyalty_tier)
