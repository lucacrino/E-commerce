--Objective: Build a scorecard for each active supplier showing: total revenue generated through their products, average product margin, number of active products, weighted average product rating, return rate across their products, and a revenue rank.


--Revenue and margin by supplier
with suppliers_revenue as(
select
s.supplier_id,
supplier_name,
sum(line_total) as total_revenue,
round(avg(100.0 * (p.unit_price - p.cost_price) / p.unit_price), 2) as avg_unit_margin_pct,
count(distinct case when p.is_active = true 
      then p.product_id end) as active_products
from
suppliers s
inner join products p on s.supplier_id = p.supplier_id
inner join order_items oi on oi.product_id = p.product_id
left join orders o on oi.order_id = o.order_id
where status not in ('returned','cancelled')
group by 1,2
),

  
--Return rate by supplier  
return_cte as(
select 
s.supplier_id,
supplier_name,
round(100.0 * count(r.return_id) / nullif(count(oi.order_item_id),0),2) as return_rate_pct
from 
products p
inner join suppliers s on s.supplier_id = p.supplier_id
inner join order_items oi on oi.product_id = p.product_id
inner join orders o on o.order_id = oi.order_id
left join returns r on r.order_id = oi.order_id
where o.status not in ('cancelled')
group by 1,2
),


--Reviews and active products
reviews_and_rating as(
select
s.supplier_id,
supplier_name,
count(r.review_id) as review_count,
round(avg(r.rating),2) as avg_rating
from
products p
inner join suppliers s on s.supplier_id = p.supplier_id
inner join reviews r on r.product_id = p.product_id
group by 1,2
)


select
sr.supplier_name,
sr.total_revenue,
sr.avg_unit_margin_pct,
sr.active_products,
round(sum(rr.avg_rating * rr.review_count) / sum(rr.review_count),2) as weighted_avg_rating,
rc.return_rate_pct,
dense_rank() over(order by sr.total_revenue desc) as revenue_rank
from
suppliers_revenue sr
left join return_cte rc on sr.supplier_id = rc.supplier_id
left join reviews_and_rating rr on sr.supplier_id = rr.supplier_id
group by 1,2,3,4,6





