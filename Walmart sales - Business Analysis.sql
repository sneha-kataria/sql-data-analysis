-- Data Analysis for Walmart Sales Group

DROP TABLE IF EXISTS walmart_sales;


CREATE TABLE walmart_sales(
                            invoice_id VARCHAR(15),
                            branch	CHAR(1),	
                            city  VARCHAR(25),  
                            customer_type	VARCHAR(15),
                            gender	VARCHAR(15),
                            product_line VARCHAR(55),	
                            unit_price	FLOAT,
                            quantity    INT, 	
                            vat	FLOAT,
                            total	FLOAT,
                            date	date,	
                            time time,
                            payment_method	VARCHAR(15),
                            rating FLOAT
                        );

Select * from walmart_sales;

-- ---------------------------------------------
-- Business Problems 
-- ---------------------------------------------

Q.1 Find the total sales amount for each branch

Select branch,
       SUM(total) as branch_total
FROM walmart_sales
GROUP BY branch;


Q.2 Calculate the average customer rating for each city.

select city,
       AVG(rating) as Avg_rating
FROM walmart_sales
GROUP BY city;


Q.3 Count the number of sales transactions for each customer type.

select customer_type,
       COUNT(*) as total_sales
FROM walmart_sales
GROUP BY customer_type;


Q.4 Find the total quantity of products sold for each product line.

select product_line,
       COUNT(quantity) as total_quantity
FROM walmart_sales
GROUP BY product_line ;


Q.5 Calculate the total VAT collected for each payment method.

select payment_method,
       SUM(vat) as total_vat
FROM walmart_sales
GROUP BY payment_method ;

Q.6 Find the total sales amount and average customer rating for each branch.

select branch,
       SUM(total) as total_sales_amount,
	   AVG(rating) as Average_rating
FROM walmart_sales
GROUP BY branch;


Q.7 Calculate the total sales amount for each city and gender combination.

select city, gender,   -- city is 1 and gender is 2
       SUM(total)
FROM walmart_sales
GROUP BY 1, 2;


Q.8 Find the average quantity of products sold for each product line to female customers.

select product_line,
	   AVG(quantity) 
FROM walmart_sales
WHERE gender = 'Female'
GROUP BY product_line;


Q.9 Count the number of sales transactions for members in each branch.

SELECT branch,
       COUNT(invoice_id) as No_of_sales
FROM walmart_sales
WHERE customer_type = 'Member'
GROUP BY branch;


Q.10 Find the total sales amount for each day. (Return day name and their total sales order DESC by amt)

SELECT
       TO_CHAR (date, 'Day') AS Day_name,
	   SUM(total) as total_sales_amount
FROM walmart_sales
GROUP BY Day_name
ORDER BY total_sales_amount DESC;


Q.11 Calculate the total sales amount for each hour of the day.

SELECT 
       EXTRACT ( HOUR FROM time) as hours,
	   SUM(total) as total_sales_amount
FROM walmart_sales
GROUP BY hours
order by total_sales_amount;


Q.12 Find the total sales amount for each month. (return month name and their sales)

SELECT
       TO_CHAR (date, 'month') AS months,
	   SUM(total) as total_sales_amount
FROM walmart_sales
GROUP BY months
ORDER BY total_sales_amount DESC;

Q.13 Calculate the total sales amount for each branch where the average customer rating is greater than 7.

SELECT branch,
       SUM(total) as total_sales_amount,
	   AVG(rating)
FROM walmart_sales
GROUP BY branch
HAVING AVG(rating) > 7;


Q.14 Find the total VAT collected for each product line where the total sales amount is more than 500.

SELECT product_line,
       SUM(vat) as total_vat
FROM walmart_sales
GROUP BY product_line
HAVING SUM(vat) > 500 ;


Q.15 Calculate the average sales amount for each gender in each branch.

SELECT branch,
       gender,
	   AVG(total) as branch_total
FROM walmart_sales
GROUP BY branch, gender
ORDER BY branch;


Q.16 Count the number of sales transactions for each day of the week.

SELECT
       TO_CHAR (date, 'Day') AS Day_name,
	   COUNT(payment_method) as no_of_sales
FROM walmart_sales
GROUP BY Day_name;


Q.17 Find the total sales amount for each city and customer type combination where the number of sales transactions is greater than 50.

SELECT city,
       customer_type,
	   SUM(total) as total_sales
FROM walmart_sales
GROUP BY city, customer_type
HAVING COUNT(payment_method) > 50
ORDER BY city;

Q.18 Calculate the average unit price for each product line and payment method combination.

SELECT product_line,
       payment_method,
	   AVG(unit_price) as avg_unit_price
FROM walmart_sales
GROUP BY 1 , 2 
ORDER BY product_line;


Q.19 Find the total sales amount for each branch and hour of the day combination.

SELECT branch,
       EXTRACT( HOUR FROM time) AS hour_of_the_day,
	   SUM(total) AS total_sales
FROM walmart_sales
GROUP BY branch, hour_of_the_day
ORDER BY branch, hour_of_the_day;



Q.20 Calculate the total sales amount and average customer rating for each product line where the total sales amount is greater than 1000.

SELECT product_line,
	   SUM(total) as total_sales,
	   AVG(rating) as avg_rating
FROM walmart_sales
GROUP BY product_line
HAVING SUM(total)  > 1000
ORDER BY product_line;


Q.21 Calculate the total sales amount for morning (6 AM to 12 PM), afternoon (12 PM to 6 PM), and evening (6 PM to 12 AM) periods using the time condition.

Select * from walmart_sales;

WITH new_table
AS
(SELECT *,
CASE
      WHEN EXTRACT(HOUR FROM time) BETWEEN 6 AND 12 THEN 'Morning'
	  WHEN EXTRACT(HOUR FROM time) > 12 AND EXTRACT(HOUR FROM time) <= 18 THEN 'Afternoon'
	  ELSE 'Evening'
END as shifts
FROM walmart_sales)

SELECT shifts,
       SUM(total) as total_sales
FROM new_table
GROUP BY shifts;






