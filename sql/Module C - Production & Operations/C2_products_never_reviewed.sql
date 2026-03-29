--Objective: Identify all active products that have never received a single review. Include the product name, category, supplier, launch date, and number of times it has been ordered.

select 
product_name,
category_name,
supplier_name,
launch_date,
count(*) as times_ordered
from
products p
inner join categories c on p.category_id = c.category_id
inner join suppliers s on p.supplier_id = s.supplier_id
inner join order_items oi on p.product_id  = oi.product_id
left join reviews r on r.product_id = p.product_id
where r.review_id is null and p.is_active = true
group by 1,2,3,4
order by 4 desc
