--Objective: For each product category, calculate the return rate (returns / items sold). Then break down each category's returns by return reason to identify the dominant root cause per category.

with return_category as (
select
c.category_name,
count(oi.order_item_id) as items_sold,
count(r.return_id) as items_returned
from 
categories c
inner join products p on p.category_id = c.category_id
inner join order_items oi on oi.product_id = p.product_id
inner join orders o on o.order_id = oi.order_id
left join returns r on r.order_id = oi.order_id
where o.status not in ('cancelled', 'returned')
group by 1
)


select 
*,
round(100 * items_returned / nullif(items_sold,0),2) as return_rate_pct
from 
return_category 
order by return_rate_pct desc

