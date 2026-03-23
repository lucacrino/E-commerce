--Objective: 3 month rolling average of gross revenue. This smooths out seasonal spikes and reveals underlying growth trends.

with monthly_revenue_cte as(
select to_char(o.delivery_date,'Mon') as month_name, 
round(sum(quantity * unit_price),2) as monthly_revenue
from orders o
natural join order_items oi
where delivery_date is not null
group by to_char(o.delivery_date,'Mon'), extract(month from o.delivery_date)
order by extract(month from o.delivery_date)
)

select *, round(avg(monthly_revenue) over(rows between 2 preceding and current row),2) as rolling_3m_avg
from monthly_revenue_cte
