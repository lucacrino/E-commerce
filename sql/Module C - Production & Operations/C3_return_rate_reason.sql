--Objective: For each product category, calculate the return rate (returns / items sold). Then break down each category's returns by return reason to identify the dominant root cause per category.

--Return rate by category
with return_by_category as (
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
),


--Return reasons by category
return_reasons as(
select
c.category_name,
r.return_reason,
count(*) as total_returns
from products p
inner join categories c   on p.category_id  = c.category_id
inner join order_items oi on oi.product_id  = p.product_id
inner join orders o       on o.order_id  = oi.order_id
inner join returns r      on r.order_id  = oi.order_id
where o.status not in ('cancelled', 'returned')
group by 1, 2
),


--Rank the reasons
ranked_reasons as(
select *,
rank() over(partition by category_name order by total_returns desc) as rk
from
return_reasons
),


--Pick the top return reasons
top_reasons as(
select 
category_name,
return_reason as top_return_reason
from
ranked_reasons
where rk = 1
)



select
rc.category_name,
rc.items_sold,
rc.items_returned,
round(100.0 * rc.items_returned / nullif(rc.items_sold, 0), 2) as return_rate_pct,
tr.top_return_reason
from
return_by_category rc
left join top_reasons tr on rc.category_name = tr.category_name
order by return_rate_pct desc


