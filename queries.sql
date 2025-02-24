use master;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    ship_mode VARCHAR(30),
    segment VARCHAR(30),
    country VARCHAR(30),
    city VARCHAR(30),
    state VARCHAR(30),
    postal_code INT,
    region VARCHAR(30),
    category VARCHAR(30),
    sub_category VARCHAR(30),
    product_id VARCHAR(30),
    cost_price INT,
    list_price INT,
    quantity INT,
    discount_percent INT,
    discount DECIMAL(10,2),
    sale_price DECIMAL(10,2),
    profit DECIMAL(10,2)
);

SELECT  * FROM Orders;

 -- Total Sales
SELECT CAST(SUM(sale_price) AS DECIMAL(10,2)) AS total_revenue
FROM Orders;

--Total Profit
SELECT CAST(SUM(profit) AS DECIMAL(10,2)) AS total_profit
FROM Orders;

--Total Orders
select count(order_id) as total_orders from Orders;

--Total Revenue By Segment
select segment,sum(sale_price) as total_revenue from Orders
group by segment
order by total_revenue desc;

-- Top 10 Product by Sales
select top 10 product_id, sum(sale_price) as total_revenue from Orders
group by product_id
order by total_revenue desc;


-- Top 5 highest selling products by region
with cte as (
select region,product_id,sum(sale_price) as sales
from Orders
group by region,product_id)

select * from (
select *
, row_number() over(partition by region order by sales desc) as rn
from cte) as A
where rn<=5;


-- Monthly Sales Comparison Between 2022 and 2023
WITH monthly_sales AS (
    SELECT 
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        SUM(sale_price) AS total_sales
    FROM Orders
    WHERE YEAR(order_date) IN (2022, 2023)
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT 
    month,
    SUM(CASE WHEN year = 2022 THEN total_sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN year = 2023 THEN total_sales ELSE 0 END) AS sales_2023
FROM monthly_sales
GROUP BY month
ORDER BY month;


-- Highest Monthly Sales for Each Product Category
with cte as (select category , month(order_date) as max_sale_month , sum(sale_price) as total_sales from Orders
group by category, month(order_date))

select * from (select * , ROW_NUMBER() over ( partition by category order by total_sales desc ) as rn 
from cte )
as A
where rn = 1;



-- Year-over-Year Sales Change by Sub-Category
WITH cte1 AS (
    SELECT 
        YEAR(order_date) AS year,
        sub_category,
        SUM(sale_price) AS total_sales
    FROM Orders
    WHERE YEAR(order_date) IN (2022, 2023)
    GROUP BY YEAR(order_date), sub_category
)
, cte2 as (SELECT 
    sub_category,
    SUM(CASE WHEN year = 2022 THEN total_sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN year = 2023 THEN total_sales ELSE 0 END) AS sales_2023
FROM cte1
GROUP BY sub_category)

select * , (sales_2023-sales_2022) as percent_change from cte2 
order by percent_change desc;








