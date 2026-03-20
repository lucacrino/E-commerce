--What is the month-by-month gross revenue, number of orders and average order value over the
--entire dataset period?

--Note: according to the Accrual Accounting principles revenues are recognized when the good/service is earned, hence delivery_date is considered.

select to_char(o.delivery_date,'Mon'), count(*) as total_orders, round(sum(line_total),2) as gross_revenue, round(avg(line_total),2) as avg_order_value
from orders o
natural join order_items ot
where delivery_date is not null
group by to_char(o.delivery_date,'Mon'), extract(month from o.delivery_date)
order by extract(month from o.delivery_date)
