create database walmart_sales_db;

-- Dataset: https://github.com/najirh/Walmart_SQL_Python

-- walmart Sales Analysis Report

-- EDA 
describe walmart_sales;

ALTER TABLE walmart_sales
MODIFY COLUMN date DATE;

SELECT DISTINCT date
FROM walmart_sales
WHERE STR_TO_DATE(date, '%Y-%m-%d') IS NULL
   OR date IS NULL
   OR date = '';

UPDATE walmart_sales
SET date = STR_TO_DATE(date, '%Y-%m-%d');


Select * from walmart_sales;

-- KPIs
select year(date) as Year,
	   count(*) as Total_Transactions,
	   sum(Sales*profit_margin) as Total_Revenue,
       sum(profit_margin) as Profit_Margins,
       sum(Profit) as Total_Profit,
       avg(rating) as Avg_rating from walmart_sales
       group by year(date)
       order by Year;

-- Q1 Find the different payment method, number of transactions and qty sold

select payment_method,
	   count(*) as Tansactions,
       sum(quantity) as Qty_Sold 
       from walmart_sales
       group by payment_method
       order by Tansactions desc;
       

-- Q2 Identify the highest rated category in each branch. displaying the branch, category and avg rating

select branch, category,avg(rating) as Avg_Rating
	   from walmart_sales
       group by branch,category
       order by Avg_Rating desc;      
       

-- Q3 Identify the busiest day for each branch  based on the number of transactions
select * from walmart_sales;
describe walmart_sales;


select date(date) as Day ,
	   Branch as Branch, 
       count(*) as Transactions 
       from walmart_sales
       where year(date)=2019 AND  month(date)=4
       group by Day, Branch 
       order by Transactions desc limit 7;
       
       
-- Q5 determine the average, minmum and maximum rating of a product for each city.
-- list the city, avg rating, minimum_rating, max_rating


select city, Avg(rating) as Avg_Rating, 
	   min(rating) as Minimum_Rating, 
       max(rating) as Maximum_rating 
       from walmart_sales
       group by city
       order by Avg_Rating desc;
       

-- Q6 calculate the total profit  for each category by considering tota_profit as
-- (Sales * profit margin), list category and total profit ordered from highest to lowest profit

select category,
	   round(sum(Sales * profit_margin),2) as Total_Profit 
       from walmart_sales
       group by category
       order by Total_Profit desc ;
       
       
-- Q7 determine the most common payment method for each branch
-- display branch and paymentmentod

select branch as Branch, 
	   count(*) as Transaction,
	   payment_method as Most_uses_Payment_method 
       from walmart_sales
       group by Branch,Most_uses_Payment_method;
       
       
       
-- Q8 categorize sales into 3 groups moring, afetnoon and evening
-- find out which of the shift and numbert of invoices

 select case
	when hour(time)<12 then 'Morning Shift'
    when hour(time) between 12 and 17 then 'Afternoon Shift'
    else 'Evening Shift'
    end as Day_Shift, sum(quantity) as Total_qty_sold from walmart_sales
    group by 1;
    
    
-- Q9 Find Sales By month

select month(date) as Month,monthname(date) as Month_Name ,sum(Sales) as Sales_By_Month 
        from walmart_sales
		group by month(date),monthname(date)
        order by month(date);
        
-- Q10 Find Sales & Profit By quater
Select quarter(date),Quarter,sum(Sales) as Sales,sum(Profit) as Profit  
        from walmart_sales group by Quarter, quarter(date) 
        order by quarter(date), Quarter;
    
-- Q11 Get the sales by category

Select category, sum(Sales) as Sales ,
		 (SUM(Sales) / (SELECT SUM(Sales) FROM walmart_sales)) * 100 AS Sales_Percentage
		from walmart_sales
		group by category;

-- Q12 Get the Qty Sold by category
 Select category, count(quantity) as Sales,
		round( (count(quantity) / (SELECT count(quantity) FROM walmart_sales)) * 100,2) AS Sales_Percentage
		from walmart_sales
		group by category;
        
        
-- Q13 Get the Profit by category
Select category, sum(Profit) as Sales,
		round( (sum(Profit) / (SELECT sum(Profit) FROM walmart_sales)) * 100,2) AS Sales_Percentage
		from walmart_sales
		group by category;
        
-- Q14 Get the Sales by hour

select hour(time) as Hour, sum(sales) as Sales from walmart_sales
			group by hour(time)
            order by hour(time);
            
            
            
-- Q15 Get the orders by hour

select hour(time) as Hour, count(quantity) as Sales from walmart_sales
			group by hour(time)
            order by hour(time);
