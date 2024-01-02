-- 1)Total Revenue
SELECT 
 round(SUM(quantity * price),2) as [Total Revenue]
FROM pizza_project.dbo.order_details AS o 
 JOIN pizza_project.dbo.pizzas as p 
 ON o.pizza_id = p.pizza_id


-- 2) Average Order Value 
-- Total order value/ order count
 SELECT 
 round(Sum(quantity * price) / Count(DISTINCT order_id),2) AS [Average Order Value]
FROM pizza_project.dbo.order_details AS o 
 JOIN pizza_project.dbo.pizzas as p 
 ON o.pizza_id = p.pizza_id

 --3) Total Pizzas Sold
 SELECT
 SUM(quantity) As [Total Pizzas Sold]
 FROM 
 pizza_project.dbo.order_details


 4) Total Orders 
 SELECT
 COUNT(DISTINCT order_id) AS [Total Orders]
 FROM 
 pizza_project.dbo.order_details


 --5) Average Pizza per Order
 -- pizzas sold /number of pizzas
SELECT
 SUM(quantity)/COUNT(DISTINCT order_id) AS [Average Pizza per Order]
FROM 
 pizza_project.dbo.order_details

 ---Question to Answer
 -- 1) Daily Trends for Total Orders
SELECT 
 FORMAT(date,'dddd') AS DayOfWeek,
 COUNT(DISTINCT order_id) AS total_orders
FROM pizza_project.dbo.orders 
GROUP BY FORMAT(date, 'dddd')
ORDER BY total_orders DESC

--2) Hourly Trend for Total Orders
SELECT 
 DATEPART(HOUR, time) as [Hour],
 COUNT(DISTINCT order_id) AS count
FROM
 pizza_project.dbo.orders 
GROUP BY 
 DATEPART(HOUR, time)
ORDER BY [Hour];


--3) Percentage of Sales by Pizza Category
--a: calculate total revenue per category 
--% sales calculated as (a:/total revenue)* 100


SELECT 
category,
SUM( quantity*price) AS revenue,
round(SUM( quantity*price)*100/(
  SELECT SUM(quantity*price)
  FROM pizza_project.dbo.order_details od2 
  JOIN pizza_project.dbo.pizzas AS p2 ON
  od2.pizza_id = p2.pizza_id),2) AS percentage_sales
FROM 
 pizza_project.dbo.pizzas AS p
 JOIN pizza_project.dbo.order_details AS od ON
 p.pizza_id = od.pizza_id
 JOIN pizza_project.dbo.pizza_types AS pt ON 
 p.pizza_type_id = pt.pizza_type_id
GROUP BY 
 category
ORDER BY 
 percentage_sales DESC

 --4) Percentage of Sales by Pizza Size
 
 SELECT 
size,
SUM( quantity*price) AS revenue,
round(SUM( quantity*price)*100/(
  SELECT SUM(quantity*price)
  FROM pizza_project.dbo.order_details od2 
  JOIN pizza_project.dbo.pizzas AS p2 ON
  od2.pizza_id = p2.pizza_id),2) AS percentage_sales
FROM 
 pizza_project.dbo.pizzas AS p
 JOIN pizza_project.dbo.order_details AS od ON
 p.pizza_id = od.pizza_id
 JOIN pizza_project.dbo.pizza_types AS pt ON 
 p.pizza_type_id = pt.pizza_type_id
GROUP BY 
 size
ORDER BY 
 percentage_sales DESC


 --5) Total Pizzas Sold by Pizza Category
SELECT 
 category,
 SUM(quantity) AS quantity_sold
FROM 
 pizza_project.dbo.pizzas AS p
 JOIN pizza_project.dbo.order_details AS od ON
 p.pizza_id = od.pizza_id
 JOIN pizza_project.dbo.pizza_types AS pt ON 
 p.pizza_type_id = pt.pizza_type_id
GROUP BY 
 category
ORDER BY 
quantity_sold DESC


--6) Top 5 Best Sellers by Total Pizzas Sold

SELECT TOP 5
 name,
 SUM(quantity) AS total_pizzas_sold
FROM 
 pizza_project.dbo.pizzas AS p
 JOIN pizza_project.dbo.order_details AS od ON
 p.pizza_id = od.pizza_id
 JOIN pizza_project.dbo.pizza_types AS pt ON 
 p.pizza_type_id = pt.pizza_type_id
GROUP BY 
 name
ORDER BY 
total_pizzas_sold DESC

--7) Bottom 5 worst sellers by Total Pizzas Sold


SELECT TOP 5
 name,
 SUM(quantity) AS total_pizzas_sold
FROM 
 pizza_project.dbo.pizzas AS p
 JOIN pizza_project.dbo.order_details AS od ON
 p.pizza_id = od.pizza_id
 JOIN pizza_project.dbo.pizza_types AS pt ON 
 p.pizza_type_id = pt.pizza_type_id
GROUP BY 
 name
ORDER BY 
total_pizzas_sold 