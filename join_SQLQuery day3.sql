-- join 

--inner join,outer join ,left join,right join ,cruss join,self join

--find orde details of customers

select 
sc.customer_id,sc.first_name,sc.last_name,sc.email,sc.street,sc.zip_code,sc.city,
so.order_id,so.order_status,
  CASE
        WHEN order_status = 1 THEN 'pending'
        WHEN order_status = 2 THEN 'processing'
        WHEN order_status = 3 THEN 'rejected'
        WHEN order_status = 4 THEN 'completed'
        ELSE 'unknown'
    END AS order_label
from sales.customers sc
join sales.orders so
on sc.customer_id = so.customer_id
where sc.first_name = 'Debra';
-- find  details of staffs  who have handled which stores

select *

from sales.staffs ss
join sales.stores sst
on ss.sttaf_id= so.customer_id



SELECT 
    count(stf.staff_id) as total_staff
    stf.last_name,
    stf.email,
    stf.phone,
    s.store_id
    s.store_name,
    s.city,
    s.state
FROM sales.staffs stf

INNER JOIN sales.stores s
    ON stf.store_id = s.store_id;



SELECT 
    st.store_name,  
    COUNT(stf.staff_id) AS total_staff
FROM sales.staffs stf
INNER JOIN sales.stores st
    ON stf.store_id = st.store_id
GROUP BY 
    st.store_name;



	-- find total quantity that customer has purchsse
	SELECT 
    CONCAT(sc.first_name, ' ', sc.last_name) AS total_name,
    SUM(soi.quantity) AS total_quantity
FROM sales.customers sc 
JOIN sales.orders so 
    ON sc.customer_id = so.customer_id
JOIN sales.order_items soi
    ON so.order_id = soi.order_id
GROUP BY 
    CONCAT(sc.first_name, ' ', sc.last_name)
HAVING 
    SUM(soi.quantity) > 10;

	-- find all the name of customers and product they have purchased 


	--logic flow sales.customer with sales.order
	--sales.order with sales.order_items
	--sales.orde_items with production.product


SELECT 
    CONCAT(sc.first_name, ' ', sc.last_name) AS customer_name,
    p.product_name,p.list_price
FROM sales.customers sc
JOIN sales.orders so 
    ON sc.customer_id = so.customer_id
JOIN sales.order_items soi 
    ON so.order_id = soi.order_id
JOIN production.products p 
    ON soi.product_id = p.product_id;

-- left join -full outr join is same 
--right join - ful outer join


--day-4
------------------------------------------------------------------------------------------
-- find the all details of left table  from this join

select *
from sales.customers sc left join sales.orders so
on sc.customer_id = so.customer_id;


-- right join give all value 
select *
from sales.customers sc right join sales.orders so
on sc.customer_id = so.customer_id;


-- ful outer join
select *
from sales.customers sc full outer join sales.orders so
on sc.customer_id = so.customer_id;


--self join 
select * from sales.customers
cross join sales.orders;


-- question number 6  from given assignment pdf
-- core logic IF price < 500 → Budget
--ELSE IF price between 500 and 2000 → Mid-Range
--ELSE → Premium



SELECT 
    p.product_name,
    c.category_name,
    p.list_price,
    CASE
        WHEN p.list_price < 500 THEN 'Budget'
        WHEN p.list_price BETWEEN 500 AND 2000 THEN 'Mid-Range'
        ELSE 'Premium'
    END AS Price_Segment
FROM production.products p
JOIN production.categories c 
    ON p.category_id = c.category_id;
----------------------------------------------------------
-- question number 7
--bulk summary means it is comprehensive summary of all  requirements

select  distinct  product_order,order_id,prodct_count,
from sales.orders so join
sales.order_items soi
on so.order_id = soi.order_id
join production.products pp
on soi.product_id = pp.product_id;














