-- walmart Sales Analysis Report

Select * from walmart_sales;

-- KPIs
select year(date) as Year,
		count(*) as Total_Transactions,
        sum(total_price*profit_margin) as Total_Revenue,
       sum(profit_margin) as Profit_Margins,
       avg(rating) as Avg_rating from walmart_sales
       group by Year
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
	   branch as Branch, 
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
-- (total_price * profit margin), list category and total profit ordered from highest to lowest profit

select category,
	   round(sum(total_price * profit_margin),2) as Total_Profit 
       from walmart_sales
       group by category
       order by Total_Profit desc ;
       
       
-- determine the most common payment method for each branch
-- display branch and paymentmentod

select branch as Branch, 
	   count(*) as Transaction,
	   payment_method as Most_uses_Payment_method 
       from walmart_sales
       group by Branch,Most_uses_Payment_method;
       
       
       
-- Q8 categorize sales into 3 groups moring, afetnoon and evening
-- find out whic of the shif and numbert of invoices

 select case
	when hour(time)<12 then 'Morning Shift'
    when hour(time) between 12 and 17 then 'Afternoon Shift'
    else 'Evening Shift'
    end as Day_Shift, sum(quantity) as Total_qty_sold from walmart_sales
    group by 1;
