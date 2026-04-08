--Objective: For each supplier, calculate the total refund amount issued on their products, the refund rate as a percentage of total revenue, and rank suppliers by refund exposure. Then compute a 3-month rolling refund total to identify whether specific suppliers have worsening refund trends.


--Revenues and refunds per supplier
with supplier_refund as(
select
supplier_name,
sum(line_total) as total_revenus,
sum(refund_amount) as total_refunds,
round(100 * sum(refund_amount) / sum(line_total),2) as refund_rate_pct,
dense_rank() over(order by sum(refund_amount) / sum(line_total) desc) as refund_rank
from products p
inner join suppliers s on p.supplier_id = s.supplier_id
inner join order_items oi on oi.product_id = p.product_id
left join returns r on r.order_id = oi.order_id
group by 1
),
