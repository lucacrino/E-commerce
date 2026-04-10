--Objective: what is the month-by-month gross revenue, number of orders and average order value over the entire dataset period?

select to_char(o.delivery_date,'Mon'), 
count(*) as total_orders, round(sum(quantity * unit_price),2) as gross_revenue, 
round(avg(line_total),2) as avg_order_value
from 
orders o
natural join order_items oi
where 
o.status not in ('cancelled','returned')
group by 
to_char(o.delivery_date,'Mon'), extract(month from o.delivery_date) 
order by 
extract(month from o.delivery_date)
