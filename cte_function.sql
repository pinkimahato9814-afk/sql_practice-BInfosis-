
-- cte(common table expression)
--temporary table
-- START WITH CTE 

--  basic syntax
--WITH cte_name AS (
 --   SELECT column1, column2
   -- FROM table_name
   -- WHERE condition)
--SELECT *
--FROM cte_name;

with brand_quantity as (
 select pb.brand_name,sum(soi.quantity) as total_quantity,
  case
    when SUM(soi.quantity) >500 then 'TOP Performer'
    else 'Standard'
  end as quantity_label
 from production.brands pb join production.products pp
 on pb.brand_id =pp.brand_id
 join sales.order_items soi
 on pp.product_id = soi.product_id
 group by pb.brand_name                   --Column 'production.brands.brand_name' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
 HAVING SUM(soi.quantity) > 100)
 SELECT * FROM brand_quantity WHERE quantity_label = 'TOP Performer';

 ------------------------------------------------------------------------------
 -- furher analysis from above query but work like table ,but not actually stored in the form of table 
 with brand_quantity_count as (
 select pb.brand_name,sum(soi.quantity) as total_quantity,
  case
    when SUM(soi.quantity) >500 then 'TOP Performer'
    else 'Standard'
  end as quantity_label
 from production.brands pb join production.products pp
 on pb.brand_id =pp.brand_id
 join sales.order_items soi
 on pp.product_id = soi.product_id
 group by pb.brand_name                   --Column 'production.brands.brand_name' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
 HAVING SUM(soi.quantity) > 100)
select quantity_label,count(brand_name)as total_brand
from brand_quantity_count group by quantity_label;

--calculate total_price according to category_name
--from existing query if we need to further analysis then we used cte funtion
WITH catewise_total_price AS (
    SELECT 
        pp.product_name,
        pc.category_name,
        pp.list_price,
        CASE
            WHEN pp.list_price < 500 THEN 'Budget'
            WHEN pp.list_price BETWEEN 500 AND 2000 THEN 'Mid-Range'
            ELSE 'premium'
        END AS price_segment
    FROM production.products pp 
    JOIN production.categories pc
        ON pp.category_id = pc.category_id)
SELECT 
    category_name,
    SUM(list_price) AS total_price
FROM catewise_total_price
GROUP BY category_name
ORDER BY total_price DESC;
-----------------------------------------------------------------------------------
-- window function
--row_number()
--rank()
--dense_rank()
--NTile()
--lead()
--lag()

-- row_Number
--when we use partitation by the there is no any record is lost
select first_name ,last_name,email,state,city,zip_code,
row_number() over(partition by city order by city) as rn
from sales.customers;

-- rank()
select  order_id,item_id,product_id,quantity,list_price,discount,
 rank() over(order by list_price) as rn
 from sales.order_items;

--dense rank
select * from(
select  order_id,item_id,product_id,quantity,list_price,discount,
 dense_rank() over(order by list_price) as rn
 from sales.order_items
 ) as list_price_details
 where rn =10;


--Ntile
-- it is uesd when need to dividing in many parts according to our reuiremrnt
-- it is used for customer segmentation
select 
first_name,last_name,email,state,city,zip_code,
 Ntile(10) over(order by city) as rn
 from sales.customers;


-- lead(next_value)
select 
first_name,last_name,email,state,city,zip_code,
lead(first_name) OVER(order by first_name) as val
from sales.customers

-- lag(previous value)
select
first_name,last_name,email,state,city,zip_code,
lag(first_name) OVER(order by first_name) as val
from sales.customers



-- creating view in sql
-- view is used in sql for security purpose
CREATE VIEW vw_order_items AS
SELECT order_id, product_id, quantity, list_price
FROM sales.order_items;

select * from vw_order_items;

-- synonym
create synonym bq for vw_order_items;
select * from bq;

-- indexing
-- indexing is mainly used for searching fast
-- single table 32 columns we can use indexing
-- only use indexing for 2 or max 3 columns
-- bydefault indexing is used in primary key ,thats why we join or search any data by using of key
--note cte don,t use storage but view,synonym indexing used storage because all store permanently in database


CREATE VIEW vw_order_details AS
SELECT 
    o.order_id,
    c.first_name,
    c.last_name,
    oi.product_id,
    oi.quantity,
    oi.list_price
FROM sales.orders o
JOIN sales.customers c 
    ON o.customer_id = c.customer_id
JOIN sales.order_items oi 
    ON o.order_id = oi.order_id;

select * from vw_order_details;



--CTE
--→ Creates a temporary table-like result
--→ You query it in the main SELECT
--Window Function
--→ Adds a new column to each row
--→ Does NOT reduce rows

--usecases
--CTE
--Breaking complex queries
--Reusing logic
--Recursive queries (hierarchies)
--Window Function
--Ranking (RANK, DENSE_RANK)
--Running totals (SUM OVER)
--Row numbering (ROW_NUMBER)