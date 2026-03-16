--Data Definition Language (ddl):

create table categories(
category_id integer primary key,
category_name varchar,
description text,
popularity_score numeric(3,2),
is_active bool,
created_at date
);


create table suppliers(
supplier_id integer primary key,
supplier_name varchar,
contact_name varchar,
contact_email varchar,
country varchar,
phone varchar,
rating numeric(2,1),
lead_time_days integer,
is_active bool,
contract_start date
);


create table products(
product_id integer primary key,
sku varchar,
product_name varchar,
brand varchar,
category_id integer,
supplier_id integer,
unit_price numeric(8,2),
cost_price numeric(8,2),
stock_quantity integer,
weight_kg numeric(5,2),
avg_rating numeric(3,1),
review_count integer,
is_active bool,
launch_date date
);


create table customers(
customer_id integer primary key,
first_name varchar,
last_name varchar,
email varchar,
phone varchar,
country varchar,
country_code char(2),
city varchar,
loyalty_tier varchar,
newsletter_subscribed bool,
registration_date date
);


create table orders(
order_id integer primary key,
customer_id integer,
order_date date,
status varchar,
payment_method varchar,
shipping_method varchar,
shipping_cost numeric(6,2),
discount_pct numeric(5,2),
coupon_code varchar,
shipping_date date,
delivery_date date,
is_gift bool
);


create table order_items(
order_item_id integer primary key,
order_id integer,
product_id integer,
quantity integer,
unit_price numeric(8,2),
line_discount_pct numeric(5,2),
line_total numeric(10,2)
);


create table reviews(
review_id integer primary key,
product_id integer,
order_id integer,
rating integer,
review_body text,
review_date date,
verified_purchase bool,
helpful_votes integer,
reported bool
);


create table returns(
return_id integer primary key,
order_id integer,
product_id integer,
return_reason varchar,
return_status varchar,
request_date date,
resolved_date date,
refund_amount numeric(8,2),
notes text
)
