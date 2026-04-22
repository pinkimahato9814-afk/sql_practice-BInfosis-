--sub query and nested sub query

--query inside next query
--inner query-->ineer query execute first
--outer query-->outer query is execute last 

--single row sub query-->inner query provides single row and single column data
-- multi row query-->inner query provides multi row and single column data

-- Write a query to find all products whose list_price is greater than the average list_price of all products.
--first_method

select avg(list_price) from sales.order_items;
select * from sales.order_items where list_price<1212.707871;

SELECT *
FROM sales.order_items
WHERE list_price > (
    SELECT AVG(list_price)
    FROM sales.order_items
);



--Find all customers who have placed at least one order.
SELECT first_name, last_name, email
FROM sales.customers
WHERE customer_id IN (
    SELECT customer_id
    FROM sales.orders
);


--Find the products that have never been ordered.
select product_id,product_name
from production .products
where product_id NOT IN (select product_id 
    from sales.order_items
	);

-- calculate second highest price by using sub query

select * from sales.order_items where list_price =
(SELECT MAX(list_price)
FROM sales.order_items
WHERE list_price < (
    SELECT MAX(list_price)
    FROM sales.order_items)
);


select * from sales.orders where order_date =
(SELECT MIN(order_date)
FROM sales.orders
WHERE order_date < (
    SELECT Min(order_date)
    FROM sales.orders
);

--calculate second order date

SELECT * 
FROM sales.orders 
WHERE order_date = (
    SELECT MIN(order_date)
    FROM sales.orders
    WHERE order_date > (
        SELECT MIN(order_date)
        FROM sales.orders
    )
);

-- find product details  whose categories are children bicycle ,comfort bicycle




SELECT pp.product_name,
       pp.brand_id,
       pp.category_id,
       pp.model_year,
       pp.list_price
FROM production.products pp
JOIN production.categories pc
    ON pp.category_id = pc.category_id
WHERE pc.category_name IN ('Children Bicycles', 'Comfort Bicycles');

----------------------------------------------------------------------------------------------------------------------------------------------


--> any -- inclusive

SELECT *
FROM sales.order_items
WHERE list_price < ANY (
    SELECT list_price
    FROM sales.order_items
    WHERE list_price IN (109.99, 189.99)
);

-->all--exclusive
SELECT *
FROM sales.order_items
WHERE list_price < ANY (
    SELECT list_price
    FROM sales.order_items
    WHERE list_price IN (109.99, 189.99)
);

----partitation or window function