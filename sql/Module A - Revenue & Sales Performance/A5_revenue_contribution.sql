--Objective: rank product categories by total revenue and compute a cumulative running total and cumulative percentage of overall revenue. Which categories account for the first 80% of revenue (Pareto)?
--Note: ~15 rows reference product_ids absent from products. delivery_date is the filter checking whether the revenue is due or not (see A1 note).

with revenue_by_category_cte as(
    select category_name, sum(line_total) as category_revenue
    from order_items oi
    left join products p 
    on oi.product_id = p.product_id
    left join categories c
    on c.category_id = p.category_id
    left join orders o
    on oi.order_id = o.order_id
    where p.product_id is not null and delivery_date is not null       --see Note for 'where' condition
    group by 1
)

select  *, 
dense_rank() over(order by category_revenue desc) as revenue_rank, 
sum(category_revenue) over(order by category_revenue desc) as cumulative_revenue, 
round(category_revenue/(select sum(category_revenue) from revenue_by_category_cte)*100,2) as revenue_pct,
round(sum(category_revenue) over(order by category_revenue desc)/(select sum(category_revenue) from revenue_by_category_cte)*100,2) as cumulative_pct
from revenue_by_category_cte












