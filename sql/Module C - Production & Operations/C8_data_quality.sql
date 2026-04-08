--Objective: Write a comprehensive data quality report that identifies: (1) orphaned FK rows across all relationships, (2) logically impossible rows (e.g. delivery_date before shipping_date, line_total inconsistent with quantity * unit_price * discount), (3) duplicate customer emails, (4) active products with zero stock.


--(1)
with orphaned_FK as(
select 
'missing supplier_id' as check_name,
'suppliers, products' as affected_table,
count(*) as issue_count
from products p
left join suppliers s on p.supplier_id = s.supplier_id
where s.supplier_id is null

union all

select
'missing product_id' as check_name,
'order_items, products' as affected_table,
count(*) as issue_count
from order_items oi
left join products p on oi.product_id = p.product_id
where p.product_id is null

union all

select
'missing customer_id' as check_name,
'orders, customers' as affected_table,
count(*) as issue_count
from orders o
left join customers c on o.customer_id = c.customer_id
where c.customer_id is null
),



--(2)
with discount_mismatch as(
select
'discount mismatch' as check_name,
'order_items' as affected_table,
count(*) as issue_count
from order_items
where abs(line_total - quantity * unit_price * (100 - line_discount_pct) / 100) > 0.01

union all

select
'inconsistent date' as check_name,
'orders' as affected_table,
count(*) as issue_count
from orders
where delivery_date < shipping_date
),



--(3)
duplicate_email as(

),



--(4)
active_with_no_stock as(

)

