--Objective: Group customers by the month of their first order (cohort). For each cohort, track how many customers placed at least one order in each subsequent month (months 0, 1, 2, ... from cohort month). Express retention as a percentage of the original cohort size.

with first_order_cte as (
    select
    c.customer_id,
    date_trunc('month', min(o.order_date)) as cohort_month
    from orders o
    inner join customers c on o.customer_id = c.customer_id
    where o.status = 'delivered'
    group by c.customer_id
),

cte2 as (
    select
    f.customer_id,
    f.cohort_month,
    date_trunc('month', o.order_date) as order_month
    from first_order_cte f
    inner join orders o on f.customer_id = o.customer_id
    where o.status = 'delivered'
),

cte3 as(
select 
customer_id,
cohort_month,
age(order_month,cohort_month) as interval_diff
from cte2
),

cte4 as(
select
to_char(cohort_month,'YYYY-MM') as cohort_month,
month_number,
count(distinct customer_id) as retained_customers
from(
     select
     customer_id,
     cohort_month,
     extract(year from interval_diff) * 12 + extract(month from interval_diff) as month_number
     from cte3
) t
group by 1,2
)


select
cohort_month,
month_number,
retained_customers,
first_value(retained_customers) over (partition by cohort_month order by month_number) as cohort_size,    
round(
      100.0 * retained_customers
      / first_value(retained_customers) over (partition by cohort_month order by month_number),1) as retention_pct      
from cte4
order by cohort_month, month_number
