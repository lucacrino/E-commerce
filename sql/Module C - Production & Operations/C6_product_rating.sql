--Objective: For the top 10 most-reviewed products, compute the rolling average rating over time. Has sentiment improved or declined since launch?


with top_10_reviewed_products as(
select
product_id,
product_name
from products p
order by review_count desc
limit 10
),

	
monthly_rating as(
select
t.product_name,
date_trunc('month', r.review_date)::date as review_month,
round(avg(rating),2) as monthly_avg_rating 
from
top_10_reviewed_products t
inner join reviews r
on r.product_id = t.product_id
group by 1,2
order by 1,2
)

--The interval between one row and the subsequent is not fixed, hence this is not a general rolling average
select 
mr.*,
round(avg(monthly_avg_rating) over(partition by mr.product_name 
                             order by review_month
							 rows between 2 preceding and current row),2) as rolling_avg
from monthly_rating mr

