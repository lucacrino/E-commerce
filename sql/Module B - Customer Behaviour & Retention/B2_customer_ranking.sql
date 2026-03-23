--Objective: For each country, rank customers by total spend and identify the top 3 spenders. Also compute each customer's share of their country's total revenue.

with country_ranking_cte as(
select country, 
first_name || ' ' || last_name as full_name, 
sum(line_total) as total_spend, 
dense_rank() over(partition by country order by sum(line_total) desc) as country_rank
from orders o
inner join customers c           
on o.customer_id = c.customer_id 
inner join order_items oi
on o.order_id = oi.order_id
where status = 'delivered'
group by 1,2
)



select *,
round(total_spend / (select sum(total_spend) 
               from country_ranking_cte cte1
			   where cte1.country = cte.country) * 100,2) as pct_of_country_revenue
from country_ranking_cte cte
where country_rank <= 3
