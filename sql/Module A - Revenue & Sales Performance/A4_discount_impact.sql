--Objective: for each discount tier (0%, 5–10%, 15–20%, 25%), let's check the number of orders, total revenue and average number of items per order. Does heavier discounting correlate with larger basket sizes?


with order_discount_cte as(
select o.order_id, trunc(coalesce(discount_pct,0)) || '%' as discount_pct, round(sum(line_total),2) as revenue, count(order_item_id) as items_ordered
from orders o
natural join order_items oi
where delivery_date is not null
group by 1,2
order by 1
)

select
case
 when discount_pct = '0%' then '0%'
 when discount_pct = '5%' or discount_pct = '10%' then '5-10%'
 when discount_pct = '15%' or discount_pct = '20%' then '15-20%'
 else '25%'
end as discount_bucket,

sum(revenue) as total_revenue, count(*) as order_count, round(avg(items_ordered),2) as avg_items_per_order
from order_discount_cte
group by 
case
 when discount_pct = '0%' then '0%'
 when discount_pct = '5%' or discount_pct = '10%' then '5-10%'
 when discount_pct = '15%' or discount_pct = '20%' then '15-20%'
 else '25%'
end
order by 2 desc
