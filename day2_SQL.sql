use bikestore1;
-- for data filtering use where clause
-- where,groupby,having,order by ->clause
select * 
from sales.customers
where "city" = 'orchard park';


-- concat function /concatination operator
-- concat first_name and last name 

select
   CONCAT(first_name, ' ',last_name) as full_name,email,state ,city,
   street,zip_code
   from sales.customers;
-- by using + operator

select 
  first_name + ' ' + last_name as full_name,email,state ,city,
   street,zip_code
  from sales.customers;


  select 
  CONCAT(product_name, '-----',list_price) as unique_product_name
  from production.products

  select 
  product_name + '----' + list_price as unique_product_name
  from production.products 
 
 -- extract year ,month and day
 select
 YEAR(order_date) as order_year,MONTH(order_date) as order_month,
 DAY(order_date) as order_day,
 DATENAME(MONTH,order_date) as month_name,
 DATENAME(WEEKDAY,order_date) as day_name
  from sales.orders;

  -- substring ,left,right
  -- extracts specific number of letters/digits from text.

  -- substring(column_name,strat,numbers to extract)
  select
   first_name,SUBSTRING(first_name,5,3) as extracted_letters
  from sales.customers;

  -- right(column_name,4)
  select
  first_name,right(first_name,4) as last_letters
  from sales.customers;


 -- left(column_name, numbers of letters to extract)
  select
  first_name,left(first_name,2) as first_letters
  from sales.customers;

 select * from sales.customers;
 --customer_id - first_name(3,5),-last_name(last 3 letters) - email(5,4) -
 --street(4,2) -city(last 3 letters) -state- zip_code(2,3)

select customer_id ,right(first_name,3) as last_name ,right(last_name,3) as last_name,SUBSTRING(email,5,5) as email,SUBSTRING(street,4,2) as street,left(city,3) as city,
state, SUBSTRING(zip_code,2,3)
 from sales.customers; 


 select 
 CONCAT(customer_id,'-',SUBSTRING(first_name,3,5),'-',RIGHT(last_name,3)
 ,'-',SUBSTRING(email,5,4),'-',SUBSTRING(street,4,2),'-',RIGHT(city,3),'-',
 state, '-',SUBSTRING(zip_code,2,3)) as customer_id,
 first_name,last_name,email,phone,street,city,zip_code,state
 from sales.customers;




 SELECT 
    CONCAT(
        customer_id,'-',
        SUBSTRING(first_name,3,5),'-',
        RIGHT(last_name,3),'-',
        SUBSTRING(email,5,4),'-',
        SUBSTRING(street,4,2),'-',
        RIGHT(city,3),'-',
        state,'-',
        SUBSTRING(zip_code,2,3)
    ) AS customer_id,
    
    first_name,
    last_name,
    email,
    phone,
    street,
    city,
    zip_code,
    state
FROM sales.customers;

 --  above both code are same

  -- uuid-> uviversal unique id
  -- guid -> global unique id 

 -- where
 -- find details of customers whose last name is burks
 select*

 from sales.customers
 where last_name = 'burks';
 -- find customers details who lives in NY(new york),or CA (calforniya)


 
  --select distinct column name,function from table_name,
  --blub datatype in sql is used for storing lage audio, video ,image
  -- club datatype is only used in oracle



  --CTE & window function
  -- view ,synonyms,indexing ,stored procedure
  RollBack
  --insert,update,delete,->mistake

  -- 15th minute
  --backup up-> differential backup
  commit 
  -- insert ,update,delete,create