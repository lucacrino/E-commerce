--What is the month-by-month gross revenue, number of orders and average order value over the entire dataset period?
--Note: according to the Accrual Accounting principles revenues are recognized when the good/service is earned (delivery_date) and not when cash is paid (order_date). This standard will be adopted across all the project.         

select to_char(o.delivery_date,'Mon'), count(*) as total_orders, round(sum(quantity * unit_price),2) as gross_revenue, round(avg(line_total),2) as avg_order_value
from orders o
natural join order_items oi
where delivery_date is not null
group by to_char(o.delivery_date,'Mon'), extract(month from o.delivery_date)
order by extract(month from o.delivery_date)
