-- Data Cleaning

-- Observe our dataset.

-- For order_details Table

SELECT * FROM order_details
LIMIT 10;

-- For orders Table

SELECT * FROM orders
LIMIT 10;

-- For pizza_types Table

SELECT * FROM pizza_types
LIMIT 10;

-- For pizzas Table

SELECT * FROM pizzas
LIMIT 10;

-- Total rows in our dataset

SELECT COUNT(*) AS No_Of_Rows FROM order_details;
SELECT COUNT(*) AS No_Of_Rows FROM orders;
SELECT COUNT(*) AS No_Of_Rows FROM pizza_types;
SELECT COUNT(*) AS No_Of_Rows FROM pizzas;	

-- Checking for missing values

-- For order_details Table

SELECT * FROM order_details
WHERE order_details_id IS NULL OR order_id IS NULL OR pizza_id IS NULL OR quantity is null;

-- For orders Table

SELECT * FROM orders
WHERE order_id IS NULL OR order_date IS NULL OR order_time IS NULL;

-- For pizza_types Table

SELECT * FROM pizza_types
WHERE pizza_type_id IS NULL OR name IS NULL OR category IS NULL OR ingredients IS Null;

-- For pizzas Table

SELECT * FROM pizzas
WHERE pizza_id IS NULL OR pizza_type_id IS NULL OR size IS NULL OR price IS Null;

-- Checking for duplicates

-- For order_details Table

SELECT order_details_id, COUNT(order_details_id) as COUNT
FROM order_details
GROUP BY order_details_id
HAVING COUNT(order_details_id)>1;

-- For orders Table

SELECT order_id, COUNT(order_id) as COUNT
FROM orders
GROUP BY order_id
HAVING COUNT(order_id)>1;

-- For pizza_type Table

SELECT pizza_type_id, COUNT(pizza_type_id) as COUNT
FROM pizza_types
GROUP BY pizza_type_id
HAVING COUNT(pizza_type_id)>1;

-- For pizzas Table

SELECT pizza_id, COUNT(pizza_id) as COUNT
FROM pizzas
GROUP BY pizza_id
HAVING COUNT(pizza_id)>1;

-- Data Analysis

-- Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS Total_orders
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM((order_details.quantity * pizzas.price)),
            2) AS Total_Revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- Calculate the average order value of store

SELECT 
    ROUND((SUM(order_details.quantity * pizzas.price) / COUNT(DISTINCT order_details.order_id)),
            2) AS Avg_Order_Value
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;


-- Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(DISTINCT order_details.order_id) AS Total_no_orders
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(order_details.order_id) DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS Total_Quantity_Sold
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY Total_Quantity_Sold DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS Total_Quantity_Sold
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY Total_Quantity_Sold DESC;

-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS Hour, COUNT(order_id) AS Order_Count
FROM
    orders
GROUP BY (HOUR(order_time))
ORDER BY Order_Count DESC;

-- Weekly order analysis

SELECT 
    DAYNAME(orders.order_date) AS Day_Of_Week,
    COUNT(DISTINCT orders.order_id) AS Total_order,
    ROUND((COUNT(DISTINCT order_id) / COUNT(DISTINCT order_date)),
            0) AS Average_daily_order
FROM
    orders
GROUP BY DAYNAME(orders.order_date)
ORDER BY Total_order DESC;

-- Monthly order analysis

SELECT 
    MONTHNAME(orders.order_date) AS Month,
    COUNT(DISTINCT orders.order_id) AS Total_Order
FROM
    orders
GROUP BY MONTHNAME(orders.order_date)
ORDER By Total_Order DESC;

-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) As No_Of_Pizza
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    category, COUNT(name) As No_Of_Pizza
FROM
    pizza_types
GROUP BY category;SELECT 
    ROUND(AVG(Quantity), 0) AS Avg_No_Of_Order_Per_Day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS Quantity
    FROM
        order_details
    JOIN orders ON order_details.order_id = orders.order_id
    GROUP BY orders.order_date) AS Quantity_Sold;
    
-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS Total_Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY Total_Revenue DESC
LIMIT 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    (ROUND((SUM(order_details.quantity * pizzas.price) / (SELECT 
                    SUM(order_details.quantity * pizzas.price)
                FROM
                    order_details
                        JOIN
                    pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100),2)) AS Percentage_Contribution
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category;

-- Analyze the cumulative revenue generated over time.

SELECT order_date, 
ROUND(sum(Revenue) OVER (ORDER BY order_date),2) AS Cumulative_Revenue 
FROM 
	(SELECT orders.order_date, SUM(order_details.quantity*pizzas.price) AS Revenue 
    FROM order_details
	JOIN orders 
	ON order_details.order_id = orders.order_id 
	JOIN pizzas 
	ON order_details.pizza_id = pizzas.pizza_id 
	GROUP BY orders.order_date) AS Daily_Revenue;
    
-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

WITH my_cte AS(
SELECT pizza_types.category, pizza_types.name, sum(order_details.quantity*pizzas.price) AS Revenue, 
RANK() OVER(PARTITION BY category ORDER BY SUM(order_details.quantity*pizzas.price) DESC) AS rn FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category, pizza_types.name)

SELECT category, name, Revenue FROM my_cte
WHERE rn <= 3;




