--Objective: For each shipping method, calculate: average days from order to delivery (for delivered orders), percentage of orders that were returned, average shipping cost, and total revenue. Does express shipping reduce return rates?

--Revenue,orders and shipping cost
with cte1 as(
select
shipping_method,
round(avg(delivery_date - order_date),2) as avg_delivery_days,
count(oi.order_item_id) as total_delivered_orders,
round(avg(shipping_cost),2) as avg_shipping_cost,
sum(line_total) as total_revenue
from
order_items oi
inner join orders o on oi.order_id = o.order_id
where
status = 'delivered'
group by 1
),


--Total returned orders
cte2 as(
select
shipping_method,
count(r.return_id) as returned_orders
from
order_items oi
inner join orders o on oi.order_id = o.order_id
inner join returns r on r.order_id = o.order_id
where o.status not in ('cancelled')
group by 1
)


select
c1.shipping_method,
c1.avg_delivery_days,
round(100.0 * c2.returned_orders / c1.total_delivered_orders,2) as return_rate_pct,
c1.avg_shipping_cost,
c1.total_revenue
from
cte1 c1
left join cte2 c2 on c1.shipping_method = c2.shipping_method
order by 2 desc




