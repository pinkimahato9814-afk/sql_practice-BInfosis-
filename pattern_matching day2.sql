select city,first_name from sales.customers
where first_name like 'D%'


select * from sales.customers;
--Query the list of CITY names from orders that do not start with vowels. Your result cannot contain duplicates.
--SUBSTR(column, start_position, length)
--CITY → the text
--1 → start from position 1 (first character)
--1 → take only 1 character

SELECT DISTINCT city
FROM sales.customers
WHERE LOWER(SUBSTRING(city,1,1)) not in ('a','e','i','o','u'); --question mark


-- start to learn pattern matching
select order_status,
 CASE
    WHEN order_status = 1 THEN 'pending'
    WHEN order_status = 2 THEN 'processing'
    WHEN order_status = 3 THEN 'rejected'
    WHEN order_status = 4 THEN 'completed'
 END as order_label
 from sales.orders;

    

