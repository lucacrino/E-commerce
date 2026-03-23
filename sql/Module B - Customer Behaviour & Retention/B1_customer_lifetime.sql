--Objective: Rank all customers by their total spend across delivered orders. Include their country, loyalty tier and number of orders placed. Show the top 20 customers globally.
--Note: ~40 orders reference customer_ids absent from customers. 

select c.customer_id, first_name || ' ' || last_name as full_name, country, loyalty_tier, sum(line_total) as total_spend, count(*) as order_count
from orders o
inner join customers c           --Remove customer_ids not in customers
on o.customer_id = c.customer_id 
inner join order_items oi
on o.order_id = oi.order_id
where status <> 'cancelled'
group by 1,2,3,4
order by total_spend desc
limit 20







