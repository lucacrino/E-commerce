--Objective: For each supplier, calculate the total refund amount issued on their products, the refund rate as a percentage of total revenue and rank suppliers by refund exposure. Then compute a rolling refund total to identify whether specific suppliers have worsening refund trends.


--Revenues and refunds per supplier
with supplier_refund as(
select
supplier_name,
sum(line_total) as total_revenues,
sum(refund_amount) as total_refunds,
round(100 * sum(refund_amount) / sum(line_total),2) as refund_rate_pct,
dense_rank() over(order by sum(refund_amount) / sum(line_total) desc) as refund_rank
from products p
inner join suppliers s on p.supplier_id = s.supplier_id
inner join order_items oi on oi.product_id = p.product_id
left join returns r on r.order_id = oi.order_id
group by 1
),


--Monthly refund per supplier
monthly_refund as(
select
supplier_name,
date_trunc('month', r.resolved_date)::date  as refund_month,
sum(refund_amount) as total_refunds
from products p
inner join suppliers s on p.supplier_id = s.supplier_id
inner join order_items oi on oi.product_id = p.product_id
left join returns r on r.order_id = oi.order_id
where r.return_status = 'refunded'
group by 1,2
order by 1,2
),


--Rolling refund total
--The interval between mr.refund_month is not exactly one month, hence this is a general rolling sum
rolling_refund as(
select
mr.supplier_name,
mr.refund_month,
sum(total_refunds) over(partition by mr.supplier_name order by mr.refund_month rows between 2 preceding and current row) as rolling_total_refund
from monthly_refund mr
order by 1,2
)


--These two queries target different types of analysis, for this reason they are splitted:

select *
from rolling_refund


select *
from supplier_refund
