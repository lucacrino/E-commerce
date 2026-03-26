--Objective: Classify each customer as 'one-time buyer' (exactly 1 delivered order) or 'repeat buyer' (2+ delivered orders). What percentage of revenue comes from each segment?

with customer_cte as(
    select 
	c.customer_id,
	count(*) as no_of_customers,
	sum(line_total) as total_revenue
    from 
	orders o
    inner join customers c           
    on o.customer_id = c.customer_id 
    inner join order_items oi
    on o.order_id = oi.order_id
    where status = 'delivered'
    group by 1
	)


select
case
when no_of_customers = 1 then 'one_time_buyer'
when no_of_customers = 2 then '2 delivered orders'
when no_of_customers >= 3 then '3+ delivered orders'
end buyer_segment,
sum(total_revenue) as total_segment_revenue,
sum(no_of_customers) as customer_count,
round(sum(total_revenue)/(select
                          sum(total_revenue)
					      from customer_cte)*100,2) as pct_of_total_revenue
from customer_cte
group by 1
order by array_position(array['one_time_buyer','2 delivered orders','3+ delivered orders'], case when no_of_customers = 1 then 'one_time_buyer'
                                                                                            when no_of_customers = 2 then '2 delivered orders'
                                                                                            when no_of_customers >= 3 then '3+ delivered orders'
                                                                                            end)
    
