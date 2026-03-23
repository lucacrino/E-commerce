--Objective: For each customer with more than one order, compute the number of days between each consecutive pair of orders. What is the average inter-order gap by loyalty tier?

with days_between_cte as(
 select 
	c.customer_id,
	loyalty_tier,
	order_date - lag(order_date) over(partition by c.customer_id order by order_date) as days_diff
	
    from 
	orders o
    inner join customers c           
    on o.customer_id = c.customer_id 
    inner join order_items oi
    on o.order_id = oi.order_id
    where status = 'delivered'
),

filtered_cte as(
select *
from days_between_cte
where days_diff >= 1
)

select loyalty_tier,
round(avg(days_diff),2) as avg_days_between_orders
from filtered_cte
group by 1
