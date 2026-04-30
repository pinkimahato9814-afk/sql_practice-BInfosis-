use bikestore1;
-- for data filtering use where clause
-- where,groupby,having,order by ->clause
select * 
from sales.customers
where "city" = 'orchard park';




--where 
--between->it simplifiy the and condition
--in -> it simplifies or condition
--or
--and
--like-> pattern matching

SELECT *
FROM sales.customers
WHERE city = 'orchard park' 
   OR city = 'fairport';

SELECT *
FROM sales.customers
WHERE city IN ('orchard park', 'fairport');


select * from sales.order_items
-- find price range of order_items between 1000 to 3000
  


  select * 
  from sales.order_items
  where list_price between 1000 and 3000;



  -- like -> pattern  matching
  -- find details of customers whose name is started from s .
select*  from sales.customers
  where first_name like '%s';


 -- find details of customers whose name is ends from s .
select*  from sales.customers
  where first_name like 's%';


   -- find details of customers whose name contain s in between.
select*  from sales.customers
  where first_name like '%s%';


-- find details of customers whose name contain u ans s in between.
select*  from sales.customers
  where first_name like 'u%s%';



 -- _ uderscore show number of letters

 --find customers detail whose first letter contain l and other threee anything
 -- find customer whose first letter l and third letter s 
 select*
 from sales.customers 
 where first_name like 'l_s_%';


 -- SQL case
-- sql query 


select *
customer_id,order_id,store_id,staff_id,order_status,
CASE
  when order_status =1 then 'pending'
  when order_status =1 then 'pending'
  when order_status =1 then 'pending'
  when order_status =1 then 'pending'
END as order_lebel






SELECT 
    customer_id,
    order_id,
    store_id,
    staff_id,
    order_status,
    CASE
        WHEN order_status = 1 THEN 'pending'
        WHEN order_status = 2 THEN 'processing'
        WHEN order_status = 3 THEN 'rejected'
        WHEN order_status = 4 THEN 'completed'
        ELSE 'unknown'
    END AS order_label


from sales.orders
where
 CASE
      WHEN order_status = 1 THEN 'pending'
        WHEN order_status = 2 THEN 'processing'
        WHEN order_status = 3 THEN 'rejected'
        WHEN order_status = 4 THEN 'completed'
        ELSE 'unknown'
    END ='rejected'
	order by 1





	select * from sales.order_items;

	SELECT 
     order_id,item_id,quantity,list_price,discount,
    (quantity * list_price *(1- discount) AS total_price
FROM sales.order_items;
  
SELECT 
    order_id,item_id,
    quantity,
    list_price,
    discount,
    quantity * list_price * (1 - discount) AS total_price
FROM sales.order_items;


SELECT 
  order_id,item_id,
    quantity,
    list_price,
    discount,

 ((quantity * list_price) * ((quantity * list_price))- discount) AS total_price
FROM sales.order_items;


select * from sales.customers ;


-- find total price of order details
--total_price between 70 to 500 --> low price
--total_price between 501 to 2500 --> low price
--total_price  more than25001 high price


SELECT 
    order_id,
    item_id,
    quantity,
    list_price,
    discount,
    quantity * list_price * (1 - discount) AS total_price,
    CASE
         WHEN quantity * list_price * (1 - discount) BETWEEN 70 AND 500 THEN 'low price'
        WHEN quantity * list_price * (1 - discount) BETWEEN 501 AND 2500 THEN 'medium price'
        WHEN quantity * list_price * (1 - discount) > 2500 THEN 'high price'
        ELSE 'very low' 
    END AS price_category
FROM sales.order_items;






