

update walmart_clean_data
SET date = STR_TO_DATE(date, '%Y-%m-%d');

ALTER TABLE walmart_clean_data
MODIFY COLUMN date DATE;

update walmart_clean_data
set time = str_to_date(time, '%H:%i:%s');


ALTER TABLE walmart_clean_data
MODIFY COLUMN time time; 

-- -- Count total records:

select count(*) as Total_records from walmart_clean_data;

-- Count payment methods and number of transactions by payment method

select payment_method , count(*) as Total_transactions from walmart_clean_data
group by 1;

-- Count distinct branches

select * from walmart_clean_data;

select count(distinct branch) from walmart_clean_data;

-- -- Find the minimum quantity sold
SELECT MIN(quantity) FROM walmart_clean_data;

-- Business Problem Q1: Find different payment methods, number of transactions, and quantity sold by payment method
select * from walmart_clean_data;

select payment_method, count(*) as Total_transactions, sum(quantity) as Total_qty_sold 
from walmart_clean_data
group by 1;


-- Project Question #2: Identify the highest-rated category in each branch
-- Display the branch, category, and avg rating

select  branch, Average_rating  , category from
(select branch, avg(rating) as Average_rating, quantity, category from walmart_clean_data
group by 1,3,4
order by 3 desc limit 1) as inter;

-- Q3: Identify the busiest day for each branch based on the number of transactions

select * from walmart_clean_data;

select Branch, count(*) as Total_transaction,dayofweek(date) as busiest_Day from walmart_clean_data
group by 1, 3
order by 3,2 desc limit 1;

-- Q4: Calculate the total quantity of items sold per payment method

select payment_method, sum(quantity) as Total_qty_sold from walmart_clean_data
group by 1;

-- Q5: Determine the average, minimum, and maximum rating of categories for each city

select avg(rating) as Average_Rating,
min(rating) as Minimum_Rating ,
max(rating) as Maximum_Rating from walmart_clean_data;

SELECT 
    AVG(rating) AS Average_Rating,
    MIN(rating) AS Minimum_Rating,
    MAX(rating) AS Maximum_Rating
FROM walmart_clean_data;

-- -- Q6: Calculate the total profit for each category
select * from walmart_clean_data;

SELECT 
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart_clean_data
GROUP BY category
ORDER BY total_profit DESC;

SELECT 
   
   (unit_price * quantity * profit_margin) AS total_profit
FROM walmart_clean_data
;

-- Q7: Determine the most common payment method for each branch

select payment_method as Most_common_patment_method, count(*) as Total_transactions from walmart_clean_data
group by 1 order by 2 desc limit 1;


-- Q8: Categorize sales into Morning, Afternoon, and Evening shifts
select * from walmart_clean_data;
 
 select case
	when hour(time)<12 then 'Morning Shift'
    when hour(time) between 12 and 17 then 'Afternoon Shift'
    else 'Evening Shift'
    end as Day_Shift, sum(quantity) as Total_qty_sold from walmart_clean_data
    group by 1;
    
    
   




