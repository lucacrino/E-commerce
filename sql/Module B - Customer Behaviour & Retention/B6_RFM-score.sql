--Objective: Compute an RFM (Recency, Frequency, Monetary) score for each customer. Recency = days since last order, Frequency = number of delivered orders, Monetary = total spend. Assign a score of 1-4 to each dimension, then classify customers into segments such as Champions, Loyal, At Risk, and Lost.

--Build the raw RFM metrics
with cte1 as(
select c.customer_id,
current_date - max(order_date) as recency_days,
count(*) filter(where status = 'delivered') as frequency,
sum(line_total) as monetary
from customers c
inner join orders o on c.customer_id = o.customer_id
join order_items oi on oi.order_id = o.order_id
where status not in ('returned','cancelled')
group by 1
),


--Apply ntile(4) for each dimension independently
cte2 as(
select *,
ntile(4) over(order by recency_days desc) as r_score,  --old orders are assigned low point
ntile(4) over(order by frequency) as f_score,          --high frequency is assigned high point
ntile(4) over(order by monetary) as m_score            --high monetary is assigned high point
from cte1
)

--Define the conditions
select *,
case
when r_score = 4 and f_score = 4 and m_score = 4 then 'Champion'
when r_score >= 3 and f_score >= 3 and m_score >= 3 then 'Loyal'
when r_score <= 2 and f_score >= 3 and m_score >= 3 then 'At Risk'
else 'Lost'
end rfm_segment
from cte2

