--  cte function(common expression table

with brand_quantity as (

 select pb.brand_name,sum(soi.quantity) as total_quantity,
  case
    when SUM(soi.quantity) >500 then 'TOP Performer'
    else 'Standard'
  end as performance_flag
 from production.brands pb join production.products pp
 on pb.brand_id =pp.brand_id
 join sales.order_items soi
 on pp.product_id = soi.product_id
 group by pb.brand_name                   --Column 'production.brands.brand_name' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
 HAVING SUM(soi.quantity) > 100)
 
 select * from brand_quantity where performance_flag ='standard';
 -----------------------------------------------------------------------------------------------------------------------------------------------
 -- simple use of cte function
 -- calculate category_price
 WITH category_price AS (
    SELECT 
        pc.category_name,
        pp.list_price
    FROM production.products pp
    JOIN production.categories pc 
        ON pp.category_id = pc.category_id
)

SELECT 
    category_name,
    SUM(list_price) AS total_price
FROM category_price
GROUP BY category_name
ORDER BY total_price DESC;

-------------------------------------------------------------------------------------------------------------
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
        ON pp.category_id = pc.category_id
)

SELECT 
    category_name,
    SUM(list_price) AS total_price
FROM catewise_total_price
GROUP BY category_name
ORDER BY total_price DESC;

-----------------------------------------------------------------------------------------------------------------------------------
-- explain about -----------------------------




select * from sales.customers;

select first_name,last_name,email,city,state,zip_code,
ROW_NUMBER() OVER(partition by city order by city) as rn
from sales.customers


-- partition
--dense_rank
-- led
  
SELECT 
    first_name,
    last_name,
    email,
    city,
    state,
    zip_code,
    LEAD(first_name) OVER (ORDER BY first_name) AS next_first_name
FROM sales.customers;
-- lag
-----indexing





 
























---window fuction-------------
 --syntax
 --select columns_names(s),
 --fun() OVER ([<PARTITION BY Clause>]
 --           [<	Order by clause>]
 --			  [<row or range clause>])
 --			 from table_name

 -- fun()
 -->select function
	 --Aggigation functions
	 -- Ranking functions
	 -- Analytical functions
-- over cluse
        -- define a window
		--1.partition by
		--2.order by
		--3.rows(define range)







CREATE TABLE test_data (
    new_id INT,
    new_cat VARCHAR(20)
);

INSERT INTO test_data (new_id, new_cat) VALUES
(100, 'Agni'),
(200, 'Agni'),
(500, 'Dharti'),
(700, 'Dharti'),
(200, 'Vayu'),
(300, 'Vayu'),
(500, 'Vayu');

select * from test_data;

SELECT 
    new_id,
    new_cat,

    SUM(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS Total,
    
    AVG(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS Average,
    
    COUNT(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS Count,
    
    MIN(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS Min,
    
    MAX(new_id) OVER (PARTITION BY new_cat ORDER BY new_id) AS Max

FROM test_data;
-- unbounded preceding and unbounded flowing

SELECT 
    new_id,new_cat,

    SUM(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS "Total",

    AVG(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Average",

    COUNT(new_id) OVER ( ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Count",

    MIN(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Min",

    MAX(new_id) OVER (ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Max"

FROM test_data;

----ranking function

SELECT 
    new_id,

    ROW_NUMBER() OVER (ORDER BY new_id) AS ROW_NUMBER,

    RANK() OVER (ORDER BY new_id) AS RANK,

    DENSE_RANK() OVER (ORDER BY new_id) AS DENSE_RANK,

    PERCENT_RANK() OVER (ORDER BY new_id) AS PERCENT_RANK

FROM test_data;

-- analytical function
